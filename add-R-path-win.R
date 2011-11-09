## put R's bin path to the system PATH variable under Windows
R.bin = normalizePath(R.home("bin"))
sys.path = Sys.getenv("PATH")
if ((shell("R --version") != 0) || !grepl(R.bin, sys.path, fixed = TRUE)) {
    system(paste("setx PATH \"", R.bin, ";", sys.path, "\"", sep = ""))
} 

