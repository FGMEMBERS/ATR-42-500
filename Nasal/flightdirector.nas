#Usage : var FD = FlightDirector.new(flightdirector property);
# var FD = FlightDirector.new("instrumentation/FD");

var FlightDirector = {
    new : func(prop) {
        var m = {parents:[FlightDirector]};

        m.lnav_text=["","HDG SEL","HDG SEL",
        "LNAV","LOC","ROLLOUT","TO/GA","TRK SEL",
        "TRK HOLD","ATT","APP"];

        m.vnav_text=["","TO/GA","ALT","V/S","VNAV PATH","VNAV-SPD",
        "VNAV ALT","G/S","FLCH SPD","FPA"];
        
        m.spd_text=["","THR","THR REF","IDLE","HOLD","SPD"];
        
        m.FDnode = props.globals.getNode(prop,1);
        m.DH=m.FDnode.getNode("DH",1);
        m.DH.setDoubleValue(350);
        m.Bank_limit_max=m.FDnode.getNode("bank-limit-max",1);
        m.Bank_limit_max.setDoubleValue(30);
        m.Bank_limit_min=m.FDnode.getNode("bank-limit-min",1);
        m.Bank_limit_min.setDoubleValue(-30);
        m.Bank_limit_switch=m.FDnode.getNode("bank-limit-switch",1);
        m.Bank_limit_switch.setIntValue(0);
        m.FPA=m.FDnode.getNode("FP-angle",1);
        m.FPA.setDoubleValue(9.9);
        m.MACHdisplay=m.FDnode.getNode("mach-display",1);
        m.MACHdisplay.setBoolValue(0);
        m.TRKdisplay=m.FDnode.getNode("track-display",1);
        m.TRKdisplay.setBoolValue(0);
        m.FPAdisplay=m.FDnode.getNode("fpa-display",1);
        m.FPAdisplay.setBoolValue(0);
        m.Lnav=m.FDnode.getNode("lnav",1);
        m.Lnav.setIntValue(0);
        m.Vnav=m.FDnode.getNode("vnav",1);
        m.Vnav.setIntValue(0);
        m.VS=m.FDnode.getNode("vs-fpm",1);
        m.VS.setDoubleValue(0);
        m.Spd=m.FDnode.getNode("speed",1);
        m.Spd.setIntValue(0);
        m.Dist=m.FDnode.getNode("signal-distance",1);
        m.Dist.setDoubleValue(0);
        m.serviceable=m.FDnode.getNode("serviceable",1);
        m.serviceable.setBoolValue(0);
        m.FP_alt=m.FDnode.getNode("FP-alt",1);
        m.FP_alt.setDoubleValue(10000);
        m.AP_disengage=m.FDnode.getNode("AP-disengage",1);
        m.AP_disengage.setBoolValue(0);
        m.AP_mode=m.FDnode.getNode("AP-mode",1);
        m.AP_mode.setBoolValue(0);
        m.AP_annun=m.FDnode.getNode("AP-annun",1);
        m.AP_annun.setValue("   ");
	m.AP_hdg = props.globals.getNode("autopilot/locks/heading",1);
        m.AP_hdg.setValue(m.lnav_text[0]);
        m.AP_hdg_bug = props.globals.getNode("autopilot/settings/heading-bug-deg",1);
        m.AP_hdg_bug.setValue(360);
        m.AP_alt = props.globals.getNode("autopilot/locks/altitude",1);
        m.AP_alt.setValue(m.vnav_text[0]);
        m.AP_alt_setting = props.globals.getNode("autopilot/settings/target-altitude-ft",1);
        m.AP_alt_setting.setDoubleValue(10000);
        m.AP_vs_setting = props.globals.getNode("autopilot/settings/vertical-speed-fpm",1);
        m.AP_vs_setting.setDoubleValue(0);
        m.AP_pitch_setting = props.globals.getNode("autopilot/settings/target-pitch-deg",1);
        m.AP_pitch_setting.setDoubleValue(0);
        m.AP_spd = props.globals.getNode("autopilot/locks/speed",1);
        m.AP_spd.setValue(m.spd_text[0]);
        m.AP_spd_setting = props.globals.getNode("autopilot/settings/target-speed-kt",1);
        m.AP_spd_setting.setDoubleValue(200);
        m.AP_mach_setting = props.globals.getNode("autopilot/settings/target-speed-mach",1);
        m.AP_mach_setting.setDoubleValue(0.4);
        m.AP_toggle = props.globals.getNode("autopilot/locks/passive-mode",1);
        m.AP_toggle.setBoolValue(1);

        m.AP_pitch_active = props.globals.getNode("autopilot/locks/pitch-engaged",1);
        m.AP_pitch_active.setBoolValue(1);
        m.AP_roll_active = props.globals.getNode("autopilot/locks/roll-engaged",1);
        m.AP_roll_active.setBoolValue(1);
        m.AP_speed_active = props.globals.getNode("autopilot/locks/speed-engaged",1);
        m.AP_speed_active.setBoolValue(1);


        m.has_gs = props.globals.getNode("instrumentation/nav/has-gs",1);
        m.is_localizer = props.globals.getNode("instrumentation/nav/nav-loc",1);

        return m;
    },

#### check FD button presses ####
    mode_set: func(str){
        var mode2 = str;
        var fdmode = me.serviceable.getValue();
            
        if(mode2 == "FD"){
            fdmode = 1-fdmode;
            
            if(fdmode==1){
                me.Lnav.setValue(6);
                me.Vnav.setValue(1);
                me.Spd.setValue(5);
                me.AP_spd_setting.setValue(200);
                me.AP_vs_setting.setValue(1500);
                me.AP_pitch_setting.setValue(10);
		me.AP_annun.setValue("   CMD");
            }else{
            me.Lnav.setValue(1);
            me.Vnav.setValue(9);
            me.Spd.setValue(0);
	    me.AP_annun.setValue("      ");
            }
            me.AP_hdg.setValue(me.lnav_text[me.Lnav.getValue()]);
            me.AP_alt.setValue(me.vnav_text[me.Vnav.getValue()]);
            me.AP_spd.setValue(me.spd_text[me.Spd.getValue()]);
            me.serviceable.setValue(fdmode);
            me.AP_mode.setValue(fdmode);
            return;
        }

        if(mode2 == "AP-ON"){
            tmpalt=getprop("position/gear-agl-ft");
            var apmode = 1- me.AP_toggle.getValue();
            if(apmode ==0){
                if(fdmode==0){
                    me.Lnav.setValue(0);
                    me.AP_hdg.setValue(me.lnav_text[0]);
                    me.Vnav.setValue(0);
                    me.AP_alt.setValue(me.vnav_text[0]);
		    me.AP_annun.setValue("AP ENG");
                }
            if(tmpalt<400)apmode =1;
            if(me.AP_disengage.getValue())apmode=1;
	    me.AP_annun.setValue("   CMD");
            }
            me.AP_toggle.setValue(apmode);
            return;
        }

        if(mode2 == "APP"){
            me.Lnav.setValue(4);
            me.AP_hdg.setValue(me.lnav_text[4]);
            me.Vnav.setValue(7);
            me.AP_alt.setValue(me.vnav_text[7]);
            return;
        }


        if(mode2 == "AP-DISENGAGE"){
            var ap_dis =me.AP_disengage.getValue();
            ap_dis=1-ap_dis;
            me.AP_disengage.setValue(ap_dis);
            if(ap_dis ==1)me.AP_toggle.setValue(1);
            return;
        }

        if(mode2 == "HDG"){
            var lm=1;
            if(me.Lnav.getValue()==lm)lm=0;
            me.Lnav.setValue(lm);
            me.AP_hdg.setValue(me.lnav_text[lm]);
            return;
        }

        if(mode2 == "LNAV"){
            var lm=3;
            var RM = getprop("autopilot/route-manager/route/num");
            if(me.Lnav.getValue()==lm or RM ==0)lm=1;
            me.Lnav.setValue(lm);
            me.AP_hdg.setValue(me.lnav_text[lm]);
            return;
        }

        if(mode2 == "LOC"){
            var lm=4;
            me.Lnav.setValue(lm);
            me.AP_hdg.setValue(me.lnav_text[lm]);
            return;
        }

        if(mode2 == "FLCH"){
            var vn=8;
            me.Vnav.setValue(vn);
            me.AP_alt.setValue(me.vnav_text[vn]);
            return;
        }

        if(mode2 == "VNAV"){
            var vn=6;
            if(getprop("autopilot/route-manager/route/num") ==0){
                vn=1;
            }else{
            var tmpalt =getprop("autopilot/route-manager/route/wp/altitude-ft");
            if(tmpalt < 0)tmpalt=35000;
            me.FP_alt.setValue(tmpalt);
            me.AP_spd_setting.setValue(250);
            }
            me.Vnav.setValue(vn);
            me.AP_alt.setValue(me.vnav_text[vn]);
        return;
        }

        if(mode2 == "ALT"){
            var vn=2;
            var tmpalt2 =getprop("position/altitude-ft");
            tmpalt2 = int(tmpalt2 *0.01) * 100;
            me.AP_alt_setting.setValue(tmpalt2);
            me.Vnav.setValue(vn);
            me.AP_alt.setValue(me.vnav_text[vn]);
            return;
        }

        if(mode2 == "VS"){
            var vn=3;
            me.AP_vs_setting.setValue(getprop("velocities/vertical-speed-fps") * 60);
            me.Vnav.setValue(vn);
            me.AP_alt.setValue(me.vnav_text[vn]);
            return;
        }

        if(mode2 == "AT"){
            var sp=5;
            var spon=me.AP_speed_active.getValue();
            sp =sp * spon;
            me.Spd.setValue(sp);
            me.AP_spd.setValue(me.spd_text[sp]);
            return;
        }

    },


    lnav_check: func(lm){
    var md = me.Fms.getBoolValue();
    if(md){
        if(lm==2)lm = 6;
    }elsif(lm==4){
            if(!me.is_localizer.getValue())lm=2;
        }
    if(me.Lnav.getValue()==lm)lm=0;
    me.Lnav.setValue(lm);
    me.AP_hdg.setValue(me.lnav_text[lm]);
    },

    vnav_check: func(vmode){
    if(me.Vnav.getValue()!=vmode){
        me.Vnav.setValue(vmode);
    }else{
        me.Vnav.setValue(0);
        }
    },

    spd_check: func(smode){
    if(me.Spd.getValue()!=smode){
        me.Spd.setValue(smode);
    }else{
        me.Spd.setValue(0);
        }
    },

    pitch_wheel : func(dir){
        var vm=me.AP_alt.getValue();
        if(vm=="FPA"){
            var temp_pitch = me.FPA.getValue();
            temp_pitch +=(dir *0.01);
            if(temp_pitch > 9.9)temp_pitch = 9.9;
            if(temp_pitch < -9.9)temp_pitch = -9.9;
            me.FPA.setValue(temp_pitch);
            }elsif(vm=="V/S"){
                var temp_vs = me.AP_vs_setting.getValue();
                   temp_vs +=(dir *10);
                   if(temp_vs < -8000) temp_vs= -8000;
                   if(temp_vs > 6000) temp_vs= 6000;
                me.AP_vs_setting.setValue(temp_vs);
                }
    return;
    },

    ias_tune : func(as){
        var ias = 0;
        if(me.MACHdisplay.getBoolValue()){
            ias=me.AP_mach_setting.getValue();
            ias += as *0.01;
            if(ias > 0.99) ias = 0.99;
            if(ias < 0.0) ias = 0.0;
            me.AP_mach_setting.setValue(ias);
        }else{
            ias=me.AP_spd_setting.getValue();
            ias += as;
            if(ias <0)ias=0;
            if(ias> 399)ias =399;
            me.AP_spd_setting.setValue(ias);
        }
        return;
    },

    hdg_tune : func(hdg){
        var hd=me.AP_hdg_bug.getValue();
        hd += hdg;
        if(hd <1)hd+=360;
        if(hd> 360)hd-=360;
        me.AP_hdg_bug.setValue(hd);
        return;
    },

    alt_tune : func(asel){
        var alt=me.AP_alt_setting.getValue();
        alt += asel;
        if(alt <0)alt=0;
        if(alt> 50000)alt=50000;
        me.AP_alt_setting.setValue(alt);
        return;
    },

    bank_limit : func(bnk){
        var bank=me.Bank_limit_switch.getValue();
        bank += bnk;
        if(bank >5)bank=5;
        if(bank <0)bank=0;
        me.Bank_limit_switch.setValue(bank);
        var tmp = bank * 5;
        if(tmp > 0){
            me.Bank_limit_min.setValue(-1 * tmp);
            me.Bank_limit_max.setValue( tmp);
        }else{
            me.Bank_limit_min.setValue(-30);
            me.Bank_limit_max.setValue( 30);
        }
    return;
    },

    AT_arm : func{
        var arm=me.AP_speed_active.getValue();
        arm=1-arm;
        me.AP_speed_active.setValue(arm);
    return;
    },

    toggle_display_mode : func(dm){
        if(dm=="mach"){
            var mc = me.MACHdisplay.getValue();
            mc =1-mc;
            if(getprop("velocities/mach") <0.40001)mc =0;
            if(mc==1){
                if(me.Spd.getValue() ==1){
                    me.Spd.setValue(2);
                    me.AP_spd.setValue(me.spd_text[2]);
                }
            }
            if(mc==0){
                if(me.Spd.getValue() ==2){
                    me.Spd.setValue(1);
                    me.AP_spd.setValue(me.spd_text[1]);
                }
            }
            me.MACHdisplay.setValue(mc);
        }elsif(dm=="trk"){
            var trk = me.TRKdisplay.getValue();
            trk =1-trk;
            me.TRKdisplay.setValue(trk);
        }elsif(dm=="fpa"){
            var fpa = me.FPAdisplay.getValue();
            fpa =1-fpa;
            
            me.FPAdisplay.setValue(fpa);
        }
    return;
    },

};
######################################

    var fldr = FlightDirector.new("/instrumentation/flightdirector");

var in_range=0;
var Defl = props.globals.getNode("/instrumentation/nav/heading-needle-deflection");
var GSDefl = props.globals.getNode("/instrumentation/nav/gs-needle-deflection-norm");
var DH = props.globals.getNode("/autopilot/route-manager/min-lock-altitude-agl-ft",1);

setlistener("/sim/signals/fdm-initialized", func {
settimer(update, 10);
});


####    update nav gps or nav setting    ####

var update = func {
var falt = getprop("position/altitude-ft");
var tmppch = 8.0 - (falt * 0.0001);
fldr.FPA.setValue(tmppch);
settimer(update, 1); 
}
