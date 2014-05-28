#pragma once

namespace OpenSSLWP8
{
	public ref class NativeCrypto sealed
	{
	public:
		Platform::String^ accept(Platform::String^ ip, int port);
		Platform::String^ get(Platform::String^ host);
	};
}
