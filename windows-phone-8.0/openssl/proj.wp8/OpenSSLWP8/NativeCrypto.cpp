#include "NativeCrypto.h"

#include <openssl/ssl.h>
#include <openssl/bio.h>
#include <openssl/err.h>

#include <string>

using namespace OpenSSLWP8;
using namespace Platform;

std::string stdString(Platform::String^ str)
{
	std::wstring wstr = str->Data();
	return std::string(wstr.begin(), wstr.end());
}

int password_cb(char *buf, int size, int rwflag, void *password)
{
	strncpy_s(buf, size, (char *)(password), size);
	buf[size - 1] = '\0';
	return strlen(buf);
}

EVP_PKEY *generatePrivateKey()
{
	EVP_PKEY *pkey = NULL;
	EVP_PKEY_CTX *pctx = EVP_PKEY_CTX_new_id(EVP_PKEY_RSA, NULL);
	EVP_PKEY_keygen_init(pctx);
	EVP_PKEY_CTX_set_rsa_keygen_bits(pctx, 2048);
	EVP_PKEY_keygen(pctx, &pkey);
	return pkey;
}

X509 *generateCertificate(EVP_PKEY *pkey)
{
	X509 *x509 = X509_new();
	X509_set_version(x509, 2);
	ASN1_INTEGER_set(X509_get_serialNumber(x509), 0);
	X509_gmtime_adj(X509_get_notBefore(x509), 0);
	X509_gmtime_adj(X509_get_notAfter(x509), (long)60*60*24*365);
	X509_set_pubkey(x509, pkey);

	X509_NAME *name = X509_get_subject_name(x509);
	X509_NAME_add_entry_by_txt(name, "C", MBSTRING_ASC, (const unsigned char*)"US", -1, -1, 0);
	X509_NAME_add_entry_by_txt(name, "CN", MBSTRING_ASC, (const unsigned char*)"YourCN", -1, -1, 0);
	X509_set_issuer_name(x509, name);
	X509_sign(x509, pkey, EVP_md5());
	return x509;
}

Platform::String^ NativeCrypto::accept(Platform::String^ _ip, int port)
{
	if (_ip == nullptr || port < 0) {
		return nullptr;
	}

	std::string ip = stdString(_ip);

	SOCKET socket = ::socket(AF_INET, SOCK_STREAM, 0);
	if (socket < 0) {
		return ref new Platform::String(L"errored; unable to open socket.\n");
	}

	struct sockaddr_in addr;
	memset((char *)&addr, 0, sizeof(addr));
	addr.sin_family = AF_INET;
	addr.sin_addr.s_addr = inet_addr(ip.c_str());
	addr.sin_port = htons(port);

	if (bind(socket, (struct sockaddr*)&addr, sizeof(addr)) < 0) {
		return ref new Platform::String(L"errored; unable to bind socket.\n");
	}

	listen(socket, 2);

	SOCKET client_socket = ::accept(socket, 0, 0);	

	SSL_load_error_strings();
	ERR_load_crypto_strings();

	OpenSSL_add_all_algorithms();
	SSL_library_init();

	SSL_CTX *ctx = SSL_CTX_new(SSLv3_server_method());
	if (ctx == NULL) {
		return ref new Platform::String(L"errored; unable to load context.\n");
	}

	EVP_PKEY *pkey = generatePrivateKey();
	X509 *x509 = generateCertificate(pkey);

	SSL_CTX_use_certificate(ctx, x509);
	SSL_CTX_set_default_passwd_cb(ctx, password_cb);
	SSL_CTX_use_PrivateKey(ctx, pkey);

	RSA *rsa=RSA_generate_key(512, RSA_F4, NULL, NULL); 
	SSL_CTX_set_tmp_rsa(ctx, rsa); 
	RSA_free(rsa);

	SSL_CTX_set_verify(ctx, SSL_VERIFY_NONE, 0);

	SSL *ssl = SSL_new(ctx);

	BIO *accept_bio = BIO_new_socket(client_socket, BIO_CLOSE);
	SSL_set_bio(ssl, accept_bio, accept_bio);

	SSL_accept(ssl);

	ERR_print_errors_fp(stderr);

	BIO *bio = BIO_pop(accept_bio);

	char buf[1024];
	while (1)
	{
		// first read data
		int r = SSL_read(ssl, buf, 1024); 
		switch (SSL_get_error(ssl, r))
		{ 
		case SSL_ERROR_NONE: 
			break;
		case SSL_ERROR_ZERO_RETURN: 
			goto end; 
		default: 
			//printf("SSL read problem");
			goto end;
		}

		int len = r;

		// now keep writing until we've written everything
		int offset = 0;
		while (len)
		{
			r = SSL_write(ssl, buf + offset, len); 
			switch (SSL_get_error(ssl, r))
			{ 
			case SSL_ERROR_NONE: 
				len -= r;
				offset += r; 
				break;
			default:
				//printf("SSL write problem");
				goto end;
			}
		}
	}

end:

	SSL_shutdown(ssl);

	BIO_free_all(bio);
	BIO_free_all(accept_bio);

	return ref new Platform::String(L"SHUTDOWN\n");
}

// example host: "encrypted.google.com"
Platform::String^ NativeCrypto::get(Platform::String^ _host)
{
	if (_host == nullptr) {
		return nullptr;
	}
	
	std::string host = stdString(_host);

	SSL_load_error_strings();
	ERR_load_crypto_strings();

	OpenSSL_add_all_algorithms();
	SSL_library_init();

	SSL_CTX *ctx = SSL_CTX_new(SSLv23_client_method());
	if (ctx == NULL) {
		return ref new Platform::String(L"errored; unable to load context.");
	}

	BIO *bio = BIO_new_ssl_connect(ctx);

	SSL *ssl;
	BIO_get_ssl(bio, &ssl);
	SSL_set_mode(ssl, SSL_MODE_AUTO_RETRY);
	
	BIO_set_conn_hostname(bio, (host + ":https").c_str());

	if (BIO_do_connect(bio) <= 0) {
		BIO_free_all(bio);
		return ref new Platform::String(L"errored; unable to connect.");
	}

	std::string request = "GET / HTTP/1.1\nHost: "+host+"\nUser Agent: Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)\nConnection: Close\n\n";

	if (BIO_puts(bio, request.c_str()) <= 0) {
		BIO_free_all(bio);
		return ref new Platform::String(L"errored; unable to write.");
	}

	std::wstring str;
	wchar_t ws[1024];
	char tmpbuf[1024];

	for (;;) {
		int len = BIO_read(bio, tmpbuf, 1024);
		if (len == 0) {
			break;
		}
		else if (len < 0) {
			if (!BIO_should_retry(bio)) {
				str.append(L"errored; read failed.");
				break;
			}
		}
		else {
			swprintf(ws, 1024, L"%hs", tmpbuf);
			str.append(ws, len);
		}
	}

	BIO_free_all(bio);

	return ref new Platform::String(str.c_str());
}
