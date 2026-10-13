ORIGIN = PWB
ORIGIN_VER = 2.1.49
PROJ = LIButil
PROJFILE = LIButil.mak
BUILDDIR = BUILD
DEBUG = 1

PBTDEPEND  = BUILD\$(PROJ).exe
PREP  = prep
PROFILE  = profile
PLIST  = plist
PROFSET  = set
PROFNMAKE  = nmake
CC  = cl
CFLAGS_G  = /AL /W2 /G2 /BATCH
CFLAGS_D  = /f /Od /Zi
CFLAGS_R  = /f- /Ot /Ol /Og /Oe /Oi /Gs
CXX  = cl
CXXFLAGS_G  = /W2 /BATCH
CXXFLAGS_D  = /f /Zi /Od
CXXFLAGS_R  = /f- /Ot /Oi /Ol /Oe /Og /Gs
ASM  = ml
AFLAGS_G  = /Cx /W2 /WX
AFLAGS_D  = /Zi
AFLAGS_R  = /nologo
MAPFILE_D  = BUILD\$(PROJ).map
MAPFILE_R  = BUILD\$(PROJ).map
LFLAGS_G  = /NOI /STACK:2048 /BATCH /ONERROR:NOEXE
LFLAGS_D  = /CO /MAP:FULL /FAR /PACKC
LFLAGS_R  = /MAP:FULL /EXE /FAR /PACKC
LINKER	= link
ILINK  = ilink
LRF  = echo > NUL
ILFLAGS  = /a /e

FILES  = Z:\MYTOOLS\LIBUTIL\SRC\LIBUTIL.C
OBJS  = BUILD\LIBUTIL.obj

all: BUILD\$(PROJ).exe

.SUFFIXES:
.SUFFIXES:
.SUFFIXES: .obj .c

BUILD\LIBUTIL.obj : Z:\MYTOOLS\LIBUTIL\SRC\LIBUTIL.C
!IF $(DEBUG)
	@$(CC) @<<BUILD\$(PROJ).rsp
/c $(CFLAGS_G)
$(CFLAGS_D) /FoBUILD\LIBUTIL.obj Z:\MYTOOLS\LIBUTIL\SRC\LIBUTIL.C
<<
!ELSE
	@$(CC) @<<BUILD\$(PROJ).rsp
/c $(CFLAGS_G)
$(CFLAGS_R) /FoBUILD\LIBUTIL.obj Z:\MYTOOLS\LIBUTIL\SRC\LIBUTIL.C
<<
!ENDIF


BUILD\$(PROJ).pbt : 
	$(PROFSET) MAKEFLAGS=
	$(PROFNMAKE) $(NMFLAGS) -f $(PROJFILE) $(PBTDEPEND)
	$(PREP) /P $(PBTDEPEND) /OT BUILD\$(PROJ).pbt

BUILD\$(PROJ).exe : $(OBJS)
!IF $(DEBUG)
	$(LRF) @<<BUILD\$(PROJ).lrf
$(RT_OBJS: = +^
) $(OBJS: = +^
)
$@
$(MAPFILE_D)
$(LIBS: = +^
) +
$(LLIBS_G: = +^
) +
$(LLIBS_D: = +^
)
$(DEF_FILE) $(LFLAGS_G) $(LFLAGS_D);
<<
!ELSE
	$(LRF) @<<BUILD\$(PROJ).lrf
$(RT_OBJS: = +^
) $(OBJS: = +^
)
$@
$(MAPFILE_R)
$(LIBS: = +^
) +
$(LLIBS_G: = +^
) +
$(LLIBS_R: = +^
)
$(DEF_FILE) $(LFLAGS_G) $(LFLAGS_R);
<<
!ENDIF
	$(LINKER) @BUILD\$(PROJ).lrf


.c.obj :
!IF $(DEBUG)
	@$(CC) @<<BUILD\$(PROJ).rsp
/c $(CFLAGS_G)
$(CFLAGS_D) /Fo$@ $<
<<
!ELSE
	@$(CC) @<<BUILD\$(PROJ).rsp
/c $(CFLAGS_G)
$(CFLAGS_R) /Fo$@ $<
<<
!ENDIF


run: BUILD\$(PROJ).exe
	BUILD\$(PROJ).exe $(RUNFLAGS)

debug: BUILD\$(PROJ).exe
	CV $(CVFLAGS) BUILD\$(PROJ).exe $(RUNFLAGS)
