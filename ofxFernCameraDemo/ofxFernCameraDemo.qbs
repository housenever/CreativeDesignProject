import qbs
import qbs.Process
import qbs.File
import qbs.FileInfo
import qbs.TextFile
import "../../../libs/openFrameworksCompiled/project/qtcreator/ofApp.qbs" as ofApp

Project{
    property string of_root: "../../.."

    ofApp {
        name: { return FileInfo.baseName(sourceDirectory) }

        files: [
            'src/main.cpp',
            'src/ofApp.cpp',
            'src/ofApp.h',
            'src/osxOpenCv2Lib/include/cv.h',
            'src/osxOpenCv2Lib/include/cv.hpp',
            'src/osxOpenCv2Lib/include/cvaux.h',
            'src/osxOpenCv2Lib/include/cvaux.hpp',
            'src/osxOpenCv2Lib/include/cvcompat.h',
            'src/osxOpenCv2Lib/include/cvstreams.h',
            'src/osxOpenCv2Lib/include/cvtypes.h',
            'src/osxOpenCv2Lib/include/cvver.h',
            'src/osxOpenCv2Lib/include/cvvidsurv.hpp',
            'src/osxOpenCv2Lib/include/cvwimage.h',
            'src/osxOpenCv2Lib/include/cxcore.h',
            'src/osxOpenCv2Lib/include/cxcore.hpp',
            'src/osxOpenCv2Lib/include/cxerror.h',
            'src/osxOpenCv2Lib/include/cxflann.h',
            'src/osxOpenCv2Lib/include/cxmat.hpp',
            'src/osxOpenCv2Lib/include/cxmisc.h',
            'src/osxOpenCv2Lib/include/cxoperations.hpp',
            'src/osxOpenCv2Lib/include/cxtypes.h',
            'src/osxOpenCv2Lib/include/highgui.h',
            'src/osxOpenCv2Lib/include/highgui.hpp',
            'src/osxOpenCv2Lib/include/ml.h',
            'src/osxOpenCv2Lib/lib/cv.a',
            'src/osxOpenCv2Lib/lib/cvaux.a',
            'src/osxOpenCv2Lib/lib/cxcore.a',
            'src/osxOpenCv2Lib/lib/highgui.a',
            'src/osxOpenCv2Lib/lib/lib_clapack.a',
            'src/osxOpenCv2Lib/lib/lib_clapack_floatstore.a',
            'src/osxOpenCv2Lib/lib/lib_flann.a',
            'src/osxOpenCv2Lib/lib/ml.a',
            'src/testApp.cpp',
            'src/testApp.h',
        ]

        of.addons: [
        ]

        // additional flags for the project. the of module sets some
        // flags by default to add the core libraries, search paths...
        // this flags can be augmented through the following properties:
        of.pkgConfigs: []       // list of additional system pkgs to include
        of.includePaths: []     // include search paths
        of.cFlags: []           // flags passed to the c compiler
        of.cxxFlags: []         // flags passed to the c++ compiler
        of.linkerFlags: []      // flags passed to the linker
        of.defines: []          // defines are passed as -D to the compiler
                                // and can be checked with #ifdef or #if in the code
        of.frameworks: []       // osx only, additional frameworks to link with the project
        of.staticLibraries: []  // static libraries
        of.dynamicLibraries: [] // dynamic libraries

        // other flags can be set through the cpp module: http://doc.qt.io/qbs/cpp-module.html
        // eg: this will enable ccache when compiling
        //
        // cpp.compilerWrapper: 'ccache'

        Depends{
            name: "cpp"
        }

        // common rules that parse the include search paths, core libraries...
        Depends{
            name: "of"
        }

        // dependency with the OF library
        Depends{
            name: "openFrameworks"
        }
    }

    property bool makeOF: true  // use makfiles to compile the OF library
                                // will compile OF only once for all your projects
                                // otherwise compiled per project with qbs
    

    property bool precompileOfMain: false  // precompile ofMain.h
                                           // faster to recompile when including ofMain.h 
                                           // but might use a lot of space per project

    references: [FileInfo.joinPaths(of_root, "/libs/openFrameworksCompiled/project/qtcreator/openFrameworks.qbs")]
}
