
// C++ Standard library
#include <iostream>
#include <string>

// Windows Runtime Library
#include <wrl.h>

// Windows Graphics
#include <dxgi1_6.h>
#include <d3d12.h>

// Support macros
#ifndef DIRECT3D_SAFE_CALL
#	ifdef _DEBUG
#		define DIRECT3D_SAFE_CALL(call) do { if (FAILED(call)) { std::cout << "D3D Error\tFile: " << __FILE__ << ", " << __LINE__ << ": " << GetLastError() << std::endl; __debugbreak(); }} while (0)
#	else
#		define DIRECT3D_SAFE_CALL(call) call
#	endif
#endif

template<typename T>
using ComPtr = Microsoft::WRL::ComPtr<T>;

ComPtr<IDXGIFactory4> queryDXGIFactory()
{
	ComPtr<IDXGIFactory4> factory;
	DIRECT3D_SAFE_CALL(CreateDXGIFactory2(0, IID_PPV_ARGS(&factory)));
	return factory;
}

int main(int argc, char** argv)
{
	auto factory = queryDXGIFactory();

	std::cout << "Found graphics adapters:" << std::endl;

	ComPtr<IDXGIAdapter1> dxgi_adapter1;
	for (UINT i = 0; factory->EnumAdapters1(i, &dxgi_adapter1) != DXGI_ERROR_NOT_FOUND; ++i)
	{
		DXGI_ADAPTER_DESC1 adapter_desc;
		dxgi_adapter1->GetDesc1(&adapter_desc);

		std::wcout << L"* " << adapter_desc.Description << std::endl;
	}

	return 0;
}
