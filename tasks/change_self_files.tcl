#!/usr/bin/tclsh
#
# ps3mfw -- PS3 MFW creator
#
# Copyright (C) Anonymous Developers (Code Monkeys)
#
# This software is distributed under the terms of the GNU General Public
# License ("GPL") version 3, as published by the Free Software Foundation.
#

# Notes: Don't Try To Replace Files Unless You Know What You Are Doing..

# Created By RazorX

# Priority: 201
# Description: Replace lv1.self, lv2_kernel.self & nas_plugin.sprx Files


# Option --self-label::
# Option --self-label1::
# Option --self-label2::
# Option --self-label3::
# Option --self-label4::
# Option --replace-lv1: Replace lv1.self
# Option --replace-lv2: Replace lv2_kernel.self
# Option --replace-nas: Replace nas_plugin.sprx
# Option --self-label5::
# Option --self-label6::
# Option --self-label7::
# Option --replace-lv2-cobra: Replace lv2_kernel.self
# Option --add-pacage: Add CORE_OS_PACAGE.pkg
# Option --replace-package: Replace CORE_OS_PACKAGE.pkg
# Option --replace-devflash6: Replace dev_flash_006.tar.aa
# Option --replace-devflash7: Replace dev_flash_007.tar.aa
# Option --replace-devflash10: Replace dev_flash_010.tar.aa
# Option --replace-devflash16: Replace dev_flash_016.tar.aa
# Option --self-label8::

# Type --self-label: label {SELF Section}
# Type --self-label1: label {Space}
# Type --self-label2: label {Guide}
# Type --self-label3: label {Guide}
# Type --self-label4: label {Space}
# Type --replace-lv1: file open {"SELF File" {self}}
# Type --replace-lv2: file open {"SELF File" {self}}
# Type --replace-nas: file open {"SPRX File" {sprx}}
# Type --self-label5: label {SELF Section}
# Type --self-label6: label {COBRA Section}
# Type --self-label7: label {Space}
# Type --replace-lv2-cobra: file open {"SELF File" {self}}
# Type --add-pacage: file open {"Package File" {pkg}}
# Type --replace-package: file open {"Package File" {pkg}}
# Type --replace-devflash6: file open {"Package File" {pkg}}
# Type --replace-devflash7: file open {"Package File" {pkg}}
# Type --replace-devflash10: file open {"Package File" {pkg}}
# Type --replace-devflash16: file open {"Package File" {pkg}}
# Type --self-label8: label {COBRA Section}

namespace eval change_self_files {

    array set ::change_self_files::options {
	
		--self-label "---------------------------------- Welcome To The SELF Section --------------------------------   : :"
		--self-label1 "                                                                                                                                                      : :"
		--self-label2 "             This TCL File Will Allow You To Replace The lv1.self, lv2_kernel.self              : :"
		--self-label3 "                                     And The nas_plugin.sprx Files. (Use Caution)                              : :"
		--self-label4 "                                                                                                                                                      : :"
		--replace-lv1 "/path/to/file"
		--replace-lv2 "/path/to/file"
		--replace-nas "/path/to/file"
		--self-label5 "--------------------------------------------------------------------------------------------------------------   : :"
		--self-label6 "------------------------------------------- Cobra Section ----------------------------------------------   : :"
		--self-label7 "                                                                                                                                                      : :"
		--replace-lv2-cobra "/path/to/file"
		--add-pacage "/path/to/file"
		--replace-package "/path/to/file"
		--replace-devflash6 "/path/to/file"
		--replace-devflash7 "/path/to/file"
		--replace-devflash10 "/path/to/file"
		--replace-devflash16 "/path/to/file"
		--self-label8 "--------------------------------------------------------------------------------------------------------------   : :"
	}

    proc main { } {	
	variable options
	
		set src $options(--replace-lv1)
		set src2 $options(--replace-lv2)
		set src3 $options(--replace-lv2-cobra)
		set pacage $options(--add-pacage)
		set package $options(--replace-package)
		set devflash6 $options(--replace-devflash6)
		set devflash7 $options(--replace-devflash7)
		set devflash10 $options(--replace-devflash10)
		set devflash16 $options(--replace-devflash16)
		set replace_nas [file join dev_flash vsh module nas_plugin.sprx]
		set replace_lv1 [file join ${::CUSTOM_UPDATE_DIR} CORE_OS_PACKAGE lv1.self]
		set replace_lv2 [file join ${::CUSTOM_UPDATE_DIR} CORE_OS_PACKAGE lv2_kernel.self]
		set pkg [file join ${::CUSTOM_UPDATE_DIR} CORE_OS_PACKAGE.pkg]
		set unpkgdir [file join ${::CUSTOM_UPDATE_DIR} CORE_OS_PACKAGE.unpkg]
		set cosunpkgdir [file join ${::CUSTOM_UPDATE_DIR} CORE_OS_PACKAGE]
		
		set replace_lv2_cobra [file join ${::CUSTOM_UPDATE_DIR} CORE_OS_PACAGE lv2_kernel.self]
		set pkg_cobra [file join ${::CUSTOM_UPDATE_DIR} CORE_OS_PACAGE.pkg]
		set unpkgdir_cobra [file join ${::CUSTOM_UPDATE_DIR} CORE_OS_PACAGE.unpkg]
		set cosunpkgdir_cobra [file join ${::CUSTOM_UPDATE_DIR} CORE_OS_PACAGE]
		set pkg_dir [file join ${::CUSTOM_UPDATE_DIR}]
			
		if {[file exists $options(--replace-lv1)] == 0} {
            log "Skipping Task: lv1.self does not exist"
        } else {
		::unpkg_archive $pkg $unpkgdir
		::cosunpkg_package [file join $unpkgdir content] $cosunpkgdir
		copy_file -force -force $src $replace_lv1
			log "Replacing lv1.self Don't Try This Unless You Know What You Are Doing.."
		::cospkg_package $cosunpkgdir [file join $unpkgdir content]
		::pkg_archive $unpkgdir $pkg
		}
		
		if {[file exists $options(--replace-lv2)] == 0} {
			log "Skipping Task: lv2_kernel.self does not exist"
		} else {
		::unpkg_archive $pkg $unpkgdir
		::cosunpkg_package [file join $unpkgdir content] $cosunpkgdir
		copy_file -force -force $src2 $replace_lv2
			log "Replacing lv2_kernel.self Don't Try This Unless You Know What You Are Doing.."
		::cospkg_package $cosunpkgdir [file join $unpkgdir content]
		::pkg_archive $unpkgdir $pkg
		}
		
		if {[file exists $options(--replace-nas)] == 0 } {
            log "Skipping Task: nas_plugin.sprx does not exist"
        } else {
            ::modify_devflash_file ${replace_nas} ::change_self_files::copy_self_file $::change_self_files::options(--replace-nas)
        }
		
		if {[file exists $options(--replace-lv2-cobra)] == 0} {
			log "Skipping Task: lv2_kernel.self does not exist"
		} else {
		::unpkg_archive $pkg_cobra $unpkgdir_cobra
		::cosunpkg_package [file join $unpkgdir_cobra content] $cosunpkgdir_cobra
		copy_file -force -force $src3 $replace_lv2_cobra
			log "Replacing lv2_kernel.self Don't Try This Unless You Know What You Are Doing.."
		::cospkg_package $cosunpkgdir_cobra [file join $unpkgdir_cobra content]
		::pkg_archive $unpkgdir_cobra $pkg_cobra
		}
		
		if {[file exists $options(--add-pacage)] == 0} {
            log "Skipping Task: CORE_OS_PACAGE.pkg does not exist"
        } else {
		copy_file -force -force $pacage $pkg_dir
			log "Adding CORE_OS_PACAGE.pkg Don't Try This Unless You Know What You Are Doing.."
		}
		
		if {[file exists $options(--replace-package)] == 0} {
            log "Skipping Task: CORE_OS_PACKAGE.pkg does not exist"
        } else {
		copy_file -force -force $package $pkg_dir
			log "Replacing CORE_OS_PACKAGE.pkg Don't Try This Unless You Know What You Are Doing.."
		}
		
		if {[file exists $options(--replace-devflash6)] == 0} {
            log "Skipping Task: dev_flash_006.tar.aa.2010_11_27_051337 does not exist"
        } else {
		copy_file -force -force $devflash6 $pkg_dir
			log "Replacing dev_flash_006.tar.aa.2010_11_27_051337 Don't Try This Unless You Know What You Are Doing.."
		}
		
		if {[file exists $options(--replace-devflash7)] == 0} {
            log "Skipping Task: dev_flash_007.tar.aa.2010_11_27_051337 does not exist"
        } else {
		copy_file -force -force $devflash7 $pkg_dir
			log "Replacing dev_flash_007.tar.aa.2010_11_27_051337 Don't Try This Unless You Know What You Are Doing.."
		}
		
		if {[file exists $options(--replace-devflash10)] == 0} {
            log "Skipping Task: dev_flash_010.tar.aa.2010_11_27_051337 does not exist"
        } else {
		copy_file -force -force $devflash10 $pkg_dir
			log "Replacing dev_flash_010.tar.aa.2010_11_27_051337 Don't Try This Unless You Know What You Are Doing.."
		}
		
		if {[file exists $options(--replace-devflash16)] == 0} {
            log "Skipping Task: dev_flash_016.tar.aa.2010_11_27_051337 does not exist"
        } else {
		copy_file -force -force $devflash16 $pkg_dir
			log "Replacing dev_flash_016.tar.aa.2010_11_27_051337 Don't Try This Unless You Know What You Are Doing.."
		}
    }

    proc copy_self_file { self src } {
        if {[file exists $src] == 0} {
            die "$src does not exist"
        } else {
            if {[file exists $self] == 0} {
                die "$self does not exist"
            } else {
                copy_file -force -force $src $self
            }
        }
    }
}