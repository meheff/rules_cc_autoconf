"""Select the addchdir implementation to match the generated spawn types."""

load("//autoconf:checks.bzl", "checks")

def addchdir_replacement_check():
    """Avoid native addchdir declarations when replacing native spawn types."""
    return checks.AC_SUBST(
        "REPLACE_POSIX_SPAWN_FILE_ACTIONS_ADDCHDIR",
        # Native spawn declarations must not be mixed with replacement types,
        # even when the addchdir probe fails. If the native spawn API is absent
        # (e.g. Windows), there is no native declaration to conflict with.
        condition = "ac_cv_func_posix_spawn_file_actions_addchdir || (HAVE_POSIX_SPAWN && ac_cv_define_REPLACE_POSIX_SPAWN)",
        if_false = "0",
        if_true = "1",
    )
