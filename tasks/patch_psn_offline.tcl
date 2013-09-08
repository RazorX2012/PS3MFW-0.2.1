#!/usr/bin/tclsh
#
# ps3mfw -- PS3 MFW creator
#
# Copyright (C) Anonymous Developers (Code Monkeys)
#
# This software is distributed under the terms of the GNU General Public
# License ("GPL") version 3, as published by the Free Software Foundation.
#

# Created By RazorX

# Priority: 700
# Description: Patch CFW To Allow Offline PSN Activation

# Option --allow-offline-activation: Patch To Allow Activation of PSN Content Offline

# Type --allow-offline-activation: combobox {{RETAIL 3.41} {RETAIL 3.55} {REBUG 3.41} {REBUG 3.55} {CFW 4.XX} {}}

namespace eval ::patch_psn_offline {

    array set ::patch_psn_offline::options {
        --allow-offline-activation ""
    }

    proc main {} {
		if {$::patch_psn_offline::options(--allow-offline-activation) == "RETAIL 3.41"} {
            set selfs {vsh.self}
            ::modify_devflash_files [file join dev_flash vsh module] $selfs ::patch_psn_offline::patch_341_self
		}
		if {$::patch_psn_offline::options(--allow-offline-activation) == "RETAIL 3.55"} {
            set selfs {vsh.self}
            ::modify_devflash_files [file join dev_flash vsh module] $selfs ::patch_psn_offline::patch_355_self
		}
		if {$::patch_psn_offline::options(--allow-offline-activation) == "REBUG 3.41"} {
            set selfs {vsh.self.cexsp}
            ::modify_devflash_files [file join dev_flash vsh module] $selfs ::patch_psn_offline::patch_341cexsp_self
            set selfs {vsh.self}
            ::modify_devflash_files [file join dev_flash vsh module] $selfs ::patch_psn_offline::patch_341vsh_self
            set selfs {vsh.self.swp}
            ::modify_devflash_files [file join dev_flash vsh module] $selfs ::patch_psn_offline::patch_341swp_self
		}
		if {$::patch_psn_offline::options(--allow-offline-activation) == "REBUG 3.55"} {
            set selfs {vsh.self.cexsp}
            ::modify_devflash_files [file join dev_flash vsh module] $selfs ::patch_psn_offline::patch_355cexsp_self
            set selfs {vsh.self}
            ::modify_devflash_files [file join dev_flash vsh module] $selfs ::patch_psn_offline::patch_355vsh_self
            set selfs {vsh.self.swp}
            ::modify_devflash_files [file join dev_flash vsh module] $selfs ::patch_psn_offline::patch_355swp_self
		}
		if {$::patch_psn_offline::options(--allow-offline-activation) == "CFW 4.XX"} {
            set selfs {vsh.self}
            ::modify_devflash_files [file join dev_flash vsh module] $selfs ::patch_psn_offline::patch_4xx_self
		}

	}	

    proc patch_341_self {self} {
        ::modify_self_file $self ::patch_psn_offline::patch_341_elf
    }
    proc patch_355_self {self} {
        ::modify_self_file $self ::patch_psn_offline::patch_355_elf
    }
    proc patch_341cexsp_self {self} {
        ::modify_self_file $self ::patch_psn_offline::patch_341cexsp_elf
    }
    proc patch_341vsh_self {self} {
        ::modify_self_file $self ::patch_psn_offline::patch_341vsh_elf
    }
    proc patch_341swp_self {self} {
        ::modify_self_file $self ::patch_psn_offline::patch_341swp_elf
    }
    proc patch_355cexsp_self {self} {
        ::modify_self_file $self ::patch_psn_offline::patch_355cexsp_elf
    }
    proc patch_355vsh_self {self} {
        ::modify_self_file $self ::patch_psn_offline::patch_355vsh_elf
    }
    proc patch_355swp_self {self} {
        ::modify_self_file $self ::patch_psn_offline::patch_355swp_elf
    }
	proc patch_4xx_self {self} {    
        ::modify_self_file $self ::patch_psn_offline::patch_4xx_elf
    }

    proc patch_341_elf {elf} {
		if {$::patch_psn_offline::options(--allow-offline-activation) == "RETAIL 3.41"} {
            log "Patching 3.41-RETAIL [file tail $elf] to allow Offline PSN-Activation"
#           allow unsigned act.dat
			set offset "0x305DC4"
            set search "\x4B\xCF\xAF\xB1"
            set replace "\x38\x60\x00\x00"
            catch_die {::patch_341_elf $elf $search 0 $replace} \
                "Unable to patch self [file tail $elf]"
#           disable deletion of act.dat
			set offset "0x305824"
            set search "\x48\x31\x43\xAD"
            set replace "\x38\x60\x00\x00"
            catch_die {::patch_341_elf $elf $search 0 $replace} \
                "Unable to patch self [file tail $elf]"
        }
			log "WARNING: Running this MFW only ON YOUR OWN RISK" 1
    }

    proc patch_355_elf {elf} {
		if {$::patch_psn_offline::options(--allow-offline-activation) == "RETAIL 3.55"} {
            log "Patching 3.55-RETAIL [file tail $elf] to allow Offline PSN-Activation"
#           allow unsigned act.dat
			set offset "0x30B230"
            set search "\x4B\xCF\x5B\x45"
            set replace "\x38\x60\x00\x00"
            catch_die {::patch_355_elf $elf $search 0 $replace} \
                "Unable to patch self [file tail $elf]"
#           disable deletion of act.dat
			set offset "0x30AC90"
            set search "\x48\x31\xB4\x65"
            set replace "\x38\x60\x00\x00"
            catch_die {::patch_355_elf $elf $search 0 $replace} \
                "Unable to patch self [file tail $elf]"
        }
			log "WARNING: Running this MFW only ON YOUR OWN RISK" 1
    }

    proc patch_341cexsp_elf {elf} {
		if {$::patch_psn_offline::options(--allow-offline-activation) == "REBUG 3.41"} {
            log "Patching 3.41-REBUG [file tail $elf] to allow Offline PSN-Activation"
#           allow unsigned act.dat
			set offset "0x305DC4"
            set search "\x4B\xCF\xAF\xB1"
            set replace "\x38\x60\x00\x00"
            catch_die {::patch_341cexsp_elf $elf $search 0 $replace} \
                "Unable to patch self [file tail $elf]"
#           disable deletion of act.dat
			set offset "0x305824"
            set search "\x48\x31\x43\xAD"
            set replace "\x38\x60\x00\x00"
            catch_die {::patch_341cexsp_elf $elf $search 0 $replace} \
                "Unable to patch self [file tail $elf]"
        }
    }

    proc patch_341vsh_elf {elf} {
		if {$::patch_psn_offline::options(--allow-offline-activation) == "REBUG 3.41"} {
            log "Patching 3.41-REBUG [file tail $elf] to allow Offline PSN-Activation"
#           allow unsigned act.dat
			set offset "0x30CEDC"
            set search  "\x4B\xCF\x3E\x99"
            set replace "\x38\x60\x00\x00"
            catch_die {::patch_341vsh_elf $elf $search 0 $replace} \
                "Unable to patch self [file tail $elf]"
#           disable deletion of act.dat
			set offset "0x30C93C"
            set search  "\x48\x31\x47\x1D"
            set replace "\x38\x60\x00\x00"
            catch_die {::patch_341vsh_elf $elf $search 0 $replace} \
                "Unable to patch self [file tail $elf]"
        }
    }

    proc patch_341swp_elf {elf} {
		if {$::patch_psn_offline::options(--allow-offline-activation) == "REBUG 3.41"} {
            log "Patching 3.41-REBUG [file tail $elf] to allow Offline PSN-Activation"
#           allow unsigned act.dat
			set offset "0x30CEDC"
            set search  "\x4B\xCF\x3E\x99"
            set replace "\x38\x60\x00\x00"
            catch_die {::patch_341swp_elf $elf $search 0 $replace} \
                "Unable to patch self [file tail $elf]"
#           disable deletion of act.dat
			set offset "0x30C93C"
            set search  "\x48\x31\x47\x1D"
            set replace "\x38\x60\x00\x00"
            catch_die {::patch_341swp_elf $elf $search 0 $replace} \
                "Unable to patch self [file tail $elf]"
        }
			log "WARNING: Running this MFW only ON YOUR OWN RISK" 1
    }

    proc patch_355cexsp_elf {elf} {
		if {$::patch_psn_offline::options(--allow-offline-activation) == "REBUG 3.55"} {
            log "Patching 3.55-REBUG [file tail $elf] to allow Offline PSN-Activation"
#           allow unsigned act.dat
			set offset "0x30B230"
            set search  "\x4B\xCF\x5B\x45"
            set replace "\x38\x60\x00\x00"
            catch_die {::patch_355cexsp_elf $elf $search 0 $replace} \
                "Unable to patch self [file tail $elf]"
#           disable deletion of act.dat
			set offset "0x30AC90"
            set search  "\x48\x31\xB4\x65"
            set replace "\x38\x60\x00\x00"
            catch_die {::patch_355cexsp_elf $elf $search 0 $replace} \
                "Unable to patch self [file tail $elf]"
        }
    }

    proc patch_355vsh_elf {elf} {
		if {$::patch_psn_offline::options(--allow-offline-activation) == "REBUG 3.55"} {
            log "Patching 3.55-REBUG [file tail $elf] to allow Offline PSN-Activation"
#           allow unsigned act.dat
			set offset "0x312308"
            set search  "\x4B\xCE\xEA\x6D"
            set replace "\x38\x60\x00\x00"
            catch_die {::patch_355vsh_elf $elf $search 0 $replace} \
                "Unable to patch self [file tail $elf]"
#           disable deletion of act.dat
			set offset "0x311D68"
            set search  "\x48\x31\xB7\xD5"
            set replace "\x38\x60\x00\x00"
            catch_die {::patch_355vsh_elf $elf $search 0 $replace} \
                "Unable to patch self [file tail $elf]"
        }
    }

    proc patch_355swp_elf {elf} {
		if {$::patch_psn_offline::options(--allow-offline-activation) == "REBUG 3.55"} {
            log "Patching 3.55-REBUG [file tail $elf] to allow Offline PSN-Activation"
#           allow unsigned act.dat
			set offset "0x312308"
            set search  "\x4B\xCE\xEA\x6D"
            set replace "\x38\x60\x00\x00"
            catch_die {::patch_355swp_elf $elf $search 0 $replace} \
                "Unable to patch self [file tail $elf]"
#           disable deletion of act.dat
			set offset "0x311D68"
            set search  "\x48\x31\xB7\xD5"
            set replace "\x38\x60\x00\x00"
            catch_die {::patch_355swp_elf $elf $search 0 $replace} \
                "Unable to patch self [file tail $elf]"
        }
			log "WARNING: Running this MFW only ON YOUR OWN RISK" 1
    }
	
    proc patch_4xx_elf {elf} {
	if {$::patch_psn_offline::options(--allow-offline-activation) == "CFW 4.XX"} {
            log "Patching 4.XX CFW [file tail $elf] to allow Offline PSN-Activation"
#           allow unsigned act.dat         
            set search "\x4B\xDC\x03\xA9"
            set replace "\x38\x60\x00\x00"
            catch_die {::patch_4xx_elf $elf $search 0 $replace} \
                "Unable to patch self [file tail $elf]"
#           disable deletion of act.dat         
            set search "\x48\x3D\x55\x6D"
            set replace "\x38\x60\x00\x00"
            catch_die {::patch_4xx_elf $elf $search 0 $replace} \
                "Unable to patch self [file tail $elf]"
        }
	}
}
