#!/usr/bin/tclsh
#
# ps3mfw -- PS3 MFW creator
#
# Copyright (C) Anonymous Developers (Code Monkeys)
#
# This software is distributed under the terms of the GNU General Public
# License ("GPL") version 3, as published by the Free Software Foundation.
#
    
# Priority: 500
# Description: Patch Alphabetical sort Order
    
# Option --patch-alpha-sort: Alphabetical sort Order for Games in the XMB
    
# Type --patch-alpha-sort: boolean

namespace eval ::patch_registory {
    
    array set ::patch_registory::options {
        --patch-alpha-sort true
    }
    
    proc main {} {
        set REGISTORY_XML [file join dev_flash vsh resource explore xmb registory.xml]
        ::modify_devflash_file ${REGISTORY_XML} ::patch_registory::sort
    }
    
    proc sort { path args } {
        log "Patching XML file [file tail $path]"
        sed_in_place [file join $path] -Game:Common.stat.rating-Game:Common.timeCreated+Game:Common.titleForSort-Game:Game.category -Game:Common.stat.rating-Game:Common.titleForSort-Game:Common.title-Game:Game.category
        sed_in_place [file join $path] -Game:Common.stat.rating+Game:Common.timeCreated+Game:Common.titleForSort-Game:Game.category -Game:Common.stat.rating+Game:Common.titleForSort-Game:Common.title-Game:Game.category
        sed_in_place [file join $path] -Game:Common.stat.rating+Game:Common.titleForSort-Game:Common.timeCreated-Game:Game.category -Game:Common.stat.rating+Game:Common.titleForSort-Game:Common.title-Game:Game.category
    }
}