module System.IFace;


class IFace {
	enum FSNode : ulong {
		OBJECT = 0x1,

		TYPE = 0x1,
		READ,
		WRITE,
		SFIND,
		SMKDIR,
		GETUID,
		GETGID,
		SETCWD,
		REMOVE,
		SGETRFN,
		SGETCWD,
		GETPERM, //ok FSI
		SETPERM, //ok FSI
		GETPATH, //OK FSI
		GETATIME, //ok FSI
		GETMTIME, //ok FSI
		GETCTIME, //ok FSI
		SETATIME, //ok FSI
		SETMTIME, //ok FSI
		SETCTIME, //ok FSI
		REMOVABLE,
		GETLENGTH,
		GETNCHILD,
		GETIDXCHILD,
	}

	enum Process : ulong {
		OBJECT = 0x2,

		S_SEND_SIGNAL = 0x1,
		S_SET_HANDLER
	}
}

/*
enum : ushort {
	VTIF_OBJTYPE,
	PRIF_OBJTYPE,
	THIF_OBJTYPE,
	FLIF_OBJTYPE,
	FNIF_OBJTYPE,
	SYIF_OBJTYPE
}*/