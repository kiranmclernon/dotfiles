require("cmake-tools").setup {
    cmake_command = "cmake",
    cmake_build_directory = "build",
    cmake_generate_options = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1" }
}
