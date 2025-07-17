-- file: main.lua
-- author: Michael Pace
-- created: 07.14.2025
-- updated: 07.17.2025

local M = {}

function M.get_os_name()
    -- Return two strings describing the OS name and OS architecture.
    -- For Windows, the OS identification is based on environment variables
    -- On unix, a call to uname is used.

    -- OS values: Windows, Linux, Mac, BSD, Solaris
    -- Architecture values: x86, x86864, powerpc, arm, mips
     
    -- On Windows, detection based on environment variable is limited
    -- to what Windows is willing to tell through environement variables.
    -- 64bits is not always indicated.

    local raw_os_name, raw_arch_name = '', ''

    -- Handle LuaJit (shortcut).
    if jit and jit.os and jit.arch then
        raw_os_name = jit.os
        raw_arch_name = jit.arch
    else
        if package.config:sub(1,1) == '\\' then
            -- Windows
            local env_OS = os.getenv('OS')
            local env_ARCH = os.getenv('PROCESSOR_ARCHITECTURE')

            if env_OS and env_ARCH then
                raw_os_name, raw_arch_name = env_OS, env_ARCH
            end
        else
            -- Handle other platforms (assume uname and popen support).
            raw_os_name = io.popen('uname -s','r'):read('*l')
            raw_arch_name = io.popen('uname -m','r'):read('*l')
        end
    end

    raw_os_name = (raw_os_name):lower()
    raw_arch_name = (raw_arch_name):lower()

    local os_patterns = {
        ['windows']     = 'Windows',
        ['linux']       = 'Linux',
        ['osx']         = 'Mac',
        ['mac']         = 'Mac',
        ['darwin']      = 'Mac',
        ['^mingw']      = 'Windows',
        ['^cygwin']     = 'Windows',
        ['bsd$']        = 'BSD',
        ['sunos']       = 'Solaris',
    }
    
    local arch_patterns = {
        ['^x86$']           = 'x86',
        ['i[%d]86']         = 'x86',
        ['amd64']           = 'x86_64',
        ['x86_64']          = 'x86_64',
        ['x64']             = 'x86_64',
        ['power macintosh'] = 'powerpc',
        ['^arm']            = 'arm',
        ['^mips']           = 'mips',
        ['i86pc']           = 'x86',
    }

    local os_name, arch_name = 'unknown', 'unknown'

    for pattern, name in pairs(os_patterns) do
        if raw_os_name:match(pattern) then
            os_name = name
            break
        end
    end
    for pattern, name in pairs(arch_patterns) do
        if raw_arch_name:match(pattern) then
            arch_name = name
            break
        end
    end
    return os_name, arch_name
end

OS_NAME,ARCH_NAME = M.get_os_name()

if OS_NAME == "Windows" then
    --!!! Handle windows OS.
elseif OS_NAME == "Linux" then
    --!! Handle linux/unix.
end
