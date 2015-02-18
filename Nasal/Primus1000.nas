###### Primus 1000 system ########
#Primus 1000 class 
# ie: var primus = P1000.new(prop);
var P1000 = {
    new : func(prop1000){
        m = { parents : [P1000]};
        m.FMS_VNAV =["VNV","FMS"];
        m.NAV_SRC = ["VOR1","VOR2","ILS1","ILS2","FMS"];
        m.RNG_STEP = [5,10,25,50,100,200,300,600,1200];
        m.MFD_MENU1 = ["                       VNAV     VSPEED     TERR     FMS",
        "            RTN       FMS      SNGP",
        "            RTN       CNCL",
        "SET      RTN        TO        ST EL     VANG        VS",
        "            RTN                      T/O       LNDG",
        "SET      RTN        V1          VR          V2",
        "SET      RTN      VREF      VAPP"];
        m.primus = props.globals.getNode(prop1000,1);
        m.PFD = m.primus.getNode("pfd",1);
        m.PFD_serv = m.PFD.getNode("serviceable",1);
        m.PFD_serv.setBoolValue(1);
        m.PFD_bright = m.PFD.getNode("dimmer",1);
        m.PFD_bright.setDoubleValue(0.8);
        m.MFD = m.primus.getNode("mfd",1);
        m.MFD_serv = m.MFD.getNode("serviceable",1);
        m.MFD_serv.setBoolValue(1);
        m.MFD_bright = m.MFD.getNode("dimmer",1);
        m.MFD_bright.setDoubleValue(0.8);
        m.MFD_menu_num = m.MFD.getNode("menu-num",1);
        m.MFD_menu_num.setIntValue(0);
        m.MFD_menu_line1 = m.MFD.getNode("menu-text",1);
        m.MFD_menu_line1.setValue(m.MFD_MENU1[0]);
        m.MFD_menu_col1 = m.MFD.getNode("menu-val[0]",1);
        m.MFD_menu_col1.setValue("     ");
        m.MFD_menu_col2 = m.MFD.getNode("menu-val[1]",1);
        m.MFD_menu_col2.setValue("     ");
        m.MFD_menu_col3 = m.MFD.getNode("menu-val[2]",1);
        m.MFD_menu_col3.setValue("     ");
        m.MFD_menu_col4 = m.MFD.getNode("menu-val[3]",1);
        m.MFD_menu_col4.setValue("     ");
        m.EICAS = m.primus.getNode("eicas",1);
        m.EICAS_serv = m.EICAS.getNode("serviceable",1);
        m.EICAS_serv.setBoolValue(1);
        m.Control = m.primus.getNode("control",1);
        m.dc550_tcas = m.Control.getNode("tcas",1);
        m.dc550_tcas.setBoolValue(0);
        m.dc550_hsi = m.Control.getNode("hsi",1);
        m.dc550_hsi.setBoolValue(0);
        m.dc550_cp = m.Control.getNode("cp",1);
        m.dc550_cp.setBoolValue(0);
        m.dc550_hpa = m.Control.getNode("hpa",1);
        m.dc550_hpa.setBoolValue(0);
        m.dc550_gspd = m.Control.getNode("timer",1);
        m.dc550_gspd.setIntValue(0);
        m.dc550_nav = m.Control.getNode("nav",1);
        m.dc550_nav.setIntValue(0);
        m.dc550_fms = m.Control.getNode("fms",1);
        m.dc550_fms.setBoolValue(0);
        m.dc550_RA = m.Control.getNode("RA-alert",1);
        m.dc550_RA.setBoolValue(1);
        m.mc800_rng = m.Control.getNode("rng-switch",1);
        m.mc800_rng.setDoubleValue(0);
        m.DH = props.globals.getNode("instrumentation/mk-viii/inputs/arinc429/decision-height",1);
        m.DH.setDoubleValue(200);
        m.NavPtr1 =m.Control.getNode("nav1ptr",1);
        m.NavPtr1.setDoubleValue(0);
        m.NavPtr2 =m.Control.getNode("nav2ptr",1);
        m.NavPtr2.setDoubleValue(0);
        m.NavPtr1_offset =m.PFD.getNode("nav1ptr-hdg-offset",1);
        m.NavPtr1_offset.setDoubleValue(0);
        m.NavPtr2_offset =m.PFD.getNode("nav2ptr-hdg-offset",1);
        m.NavPtr2_offset.setDoubleValue(0);
         m.CRStype =m.primus.getNode("course-string",1);
        m.CRStype.setValue("CRS");
         m.CRSheading =m.primus.getNode("course-heading",1);
        m.CRSheading.setDoubleValue(0);
         m.GS_inrange =m.primus.getNode("GS-in-range",1);
        m.GS_inrange.setBoolValue(0);
         m.GS_deflection =m.primus.getNode("GS-deflection",1);
        m.GS_deflection.setDoubleValue(0);
         m.CRSdeflection =m.primus.getNode("course-deflection",1);
        m.CRSdeflection.setDoubleValue(0);
         m.NavDist =m.primus.getNode("nav-dist-nm",1);
        m.NavDist.setDoubleValue(0);
        m.NavType =m.primus.getNode("nav-type",1);
        m.NavType.setIntValue(0);
        m.NavString =m.primus.getNode("nav-string",1);
        m.NavString.setValue("VOR1");
        m.NavTime =m.primus.getNode("nav-time",1);
        m.NavTime.setValue("- - : - -");
        m.NavID =m.primus.getNode("nav-id",1);
        m.NavID.setValue("");
        m.fms_mode=m.primus.getNode("fms-mode",1);
        m.fms_mode.setValue(m.FMS_VNAV[0]);
        m.FDmode = m.primus.getNode("fdmode",1);
        m.FDmode.setBoolValue(1);
        m.baro_mode=m.primus.getNode("baro-mode",1);
        m.baro_mode.setBoolValue(1);
        m.baro_kpa = m.primus.getNode("baro-kpa",1);
        m.baro_kpa.setValue("     ");
        m.IAS = props.globals.getNode("instrumentation/airspeed-indicator/indicated-speed-kt",1);
        m.ALT = props.globals.getNode("instrumentation/altimeter/indicated-altitude-ft",1);
    return m;
    },
#### convert inhg to kpa ####
    calc_kpa : func(){
        var kp = getprop("instrumentation/altimeter/setting-inhg");
        var buf="";
        if(me.dc550_hpa.getBoolValue()){
            kp = kp * 33.8637526;
            buf = sprintf("%4.0f",kp);
        }else{
            buf = sprintf("%2.2f",kp);
        }
        me.baro_kpa.setValue(buf);
    },
#### pointer needle update ####
    get_pointer_offset : func(test,src){
        var hdg = getprop("/orientation/heading-magnetic-deg");
        if(test==0 or test == nil)return 0.0;
        if(test == 1){
            offset=getprop("/instrumentation/nav["~src~"]/heading-deg");
            if(offset == nil)offset=0.0;
            offset -= hdg;
            if(offset < -180){offset += 360;}
            elsif(offset > 180){offset -= 360;}
        }elsif(test == 2){
            offset = getprop("/instrumentation/kr-87/outputs/needle-deg");
        }elsif(test == 3){
                offset = getprop("/autopilot/internal/true-heading-error-deg");
        }
        return offset;
    },
#### dc550 control ####
    dc550_set : func(dcmode){
        var tmp = 0;
        var dc = dcmode;
        if(dc == "tcas"){
            tmp = me.dc550_tcas.getBoolValue();
            me.dc550_tcas.setBoolValue(1-tmp);
        }elsif(dc == "ra-up"){
            tmp = me.DH.getValue();
            tmp +=5;
            if(tmp>1000)tmp=1000;
            me.DH.setValue(tmp);
        }elsif(dc == "hsi"){
            tmp = me.dc550_hsi.getBoolValue();
            me.dc550_hsi.setBoolValue(1-tmp);
        }elsif(dc=="cp"){
            tmp = me.dc550_cp.getBoolValue();
            me.dc550_cp.setBoolValue(1-tmp);
        }elsif(dc=="hpa"){
            tmp = me.dc550_hpa.getBoolValue();
            me.dc550_hpa.setBoolValue(1-tmp);
            me.calc_kpa();
        }elsif(dc=="ttg"){
            tmp = me.dc550_gspd.getValue();
            if(tmp ==0){
                tmp=1;
            }else{
                tmp=0;
            }
            me.dc550_gspd.setIntValue(tmp);
        }elsif(dc=="et"){
            me.dc550_gspd.setIntValue(2);
        }elsif(dc=="nav"){
            var nv = me.dc550_nav.getValue();
            nv= 1- nv;
            me.dc550_nav.setValue(nv);
            me.dc550_fms.setBoolValue(0);
            me.fms_mode.setValue(me.FMS_VNAV[0]);
            if(getprop("instrumentation/nav["~nv~"]/has-gs")){
                me.NavType.setValue(2 + nv);
            }else{
                me.NavType.setValue(0 + nv);
            }
        }elsif(dc=="fms"){
            if(getprop("autopilot/route-manager/route/num") > 0){
                me.dc550_fms.setBoolValue(1);
                me.NavType.setValue(4);
                me.fms_mode.setValue(me.FMS_VNAV[1]);
            }
        me.NavString.setValue(me.NAV_SRC[me.NavType.getValue()]);
        }
    },
#### update nav info  ####
    update_nav : func{
        me.GS_inrange.setValue(0);
        me.GS_deflection.setValue(0);
        var nm_calc = 0;
        var id =" ";
        var ttg = "- - : - -";
        if(me.dc550_fms.getBoolValue()){
            me.CRStype.setValue("DTK");
            me.CRSdeflection.setValue(0);
            var maghdg=getprop("autopilot/settings/true-heading-deg");
            maghdg -=getprop("environment/magnetic-variation-deg");
            if(maghdg>359)maghdg-=360;
            if(maghdg<0)maghdg+=360;
            me.CRSheading.setValue(maghdg);
            nm_calc = getprop("/autopilot/route-manager/wp/dist");
            if(nm_calc == nil)nm_calc = 0.0;
            id = getprop("autopilot/route-manager/wp/id");
            if(id ==nil)id= "   ";
            me.NavType.setValue(4);
            ttg=getprop("autopilot/route-manager/wp/eta");
        }else{
            me.CRStype.setValue("CRS");
            nm_calc = 0;
            var nv = me.dc550_nav.getValue();
            me.CRSdeflection.setValue(getprop("/instrumentation/nav["~nv~"]/heading-needle-deflection"));
            me.CRSheading.setValue(getprop("/instrumentation/nav["~nv~"]/radials/selected-deg"));
            if(getprop("/instrumentation/nav["~nv~"]/data-is-valid")){
                nm_calc = getprop("/instrumentation/nav["~nv~"]/nav-distance");
                if(nm_calc == nil)nm_calc = 0.0;
                nm_calc = 0.000539 * nm_calc;
                if(getprop("/instrumentation/nav["~nv~"]/has-gs")){
                    me.NavType.setValue(2);
                    if(nm_calc<30)me.GS_inrange.setValue(1);
                    var df = getprop("/instrumentation/nav["~nv~"]/gs-needle-deflection");
                    if(df>10)df=10;
                    if(df<-10)df=-10;
                    me.GS_deflection.setValue(df);
                }
                id = getprop("instrumentation/nav["~nv~"]/nav-id");
                if(id ==nil)id= "---";
                ttg=getprop("instrumentation/dme/indicated-time-min");
                if(ttg==nil or ttg == 0){
                    ttg="- - : - -";
                }else{
                var buf = ttg;
                ttg=sprintf("%2.0s:%0.2s",buf,buf);
                }
            }
        }
    me.NavDist.setValue(nm_calc);
    me.NavString.setValue(me.NAV_SRC[me.NavType.getValue()]);
    me.NavID.setValue(id);
    me.NavTime.setValue(ttg);
    var RA =0;
    tmp =me.DH.getValue();
    if(tmp > getprop("position/altitude-agl-ft") and tmp !=0)RA=1;
    me.dc550_RA.setBoolValue(RA);
    },
#### update pfd  ####
    update_pfd : func{
    me.NavPtr1_offset.setValue(me.get_pointer_offset(me.NavPtr1.getValue(),0));
    me.NavPtr2_offset.setValue(me.get_pointer_offset(me.NavPtr2.getValue(),1));
    me.update_nav();
    },
#### MC800 controls  ####
    mc800_input : func(mcmd){
        var tmp =0;
        if(mcmd=="radar-up"){
            tmp=me.mc800_rng.getValue();
            tmp +=1;
            if(tmp > 8)tmp=8;
            me.mc800_rng.setValue(tmp);
            setprop("instrumentation/radar/range",me.RNG_STEP[tmp]);
        }elsif(mcmd=="radar-dn"){
            tmp=me.mc800_rng.getValue();
            tmp -=1;
            if(tmp < 0)tmp=0;
            me.mc800_rng.setValue(tmp);
            setprop("instrumentation/radar/range",me.RNG_STEP[tmp]);
        }elsif(mcmd=="dat"){
            tmp=getprop("instrumentation/radar/display-controls/data");
            tmp=1-tmp;
            setprop("instrumentation/radar/display-controls/data",tmp);
        }elsif(mcmd=="wx"){
            tmp=getprop("instrumentation/radar/display-controls/WX");
            tmp=1-tmp;
            setprop("instrumentation/radar/display-controls/WX",tmp);
        }elsif(mcmd=="tcas"){
            tmp=getprop("instrumentation/radar/display-controls/pos");
            tmp=1-tmp;
            setprop("instrumentation/radar/display-controls/pos",tmp);
            setprop("instrumentation/radar/display-controls/symbol",tmp);
        }elsif(mcmd=="map"){
            tmp=getprop("instrumentation/radar/display-mode");
            if(tmp == "plan"){
                setprop("instrumentation/radar/display-mode","map");
            }else{
                setprop("instrumentation/radar/display-mode","plan");
            }
            setprop("instrumentation/radar/display-controls/pos",tmp);
            setprop("instrumentation/radar/display-controls/symbol",tmp);
        }
    },
#### MFD controller  ####
    mfd_menu : func(inp){
        var pg =me.MFD_menu_num.getValue();
        var altsetting=getprop("autopilot/settings/target-altitude-ft");
        if(inp=="page0"){
            pg=0;
        }elsif(inp=="page1"){
            if(pg==1){
                pg=2;
            }elsif(pg==0){
                pg=1;
            }
        }elsif(inp=="page2"){
            if(pg==0){
                pg=4;
            }elsif(pg==1){
                pg=3;
            }elsif(pg==4){
                pg=5;
            }
        }elsif(inp=="page3"){
            if(pg==4)pg=6;
        }elsif(inp=="page4"){
        }elsif(inp=="alt-dec"){
            altsetting -=100;
            if(altsetting < 0)altsetting=0;
        }elsif(inp=="alt-inc"){
        altsetting +=100;
            if(altsetting > 45000)altsetting=45000;
        }
        setprop("autopilot/settings/target-altitude-ft",altsetting);
        
        if(pg == 0){
            me.MFD_menu_col1.setValue("        ");
            me.MFD_menu_col2.setValue("        ");
            me.MFD_menu_col3.setValue("        ");
            me.MFD_menu_col4.setValue("        ");
        }elsif(pg==1){
            me.MFD_menu_col1.setValue("        ");
            me.MFD_menu_col2.setValue("        ");
            me.MFD_menu_col3.setValue("        ");
            me.MFD_menu_col4.setValue("        ");
        }elsif(pg==2){
            me.MFD_menu_col1.setValue("  VNAV ");
            me.MFD_menu_col2.setValue("        ");
            me.MFD_menu_col3.setValue("        ");
            me.MFD_menu_col4.setValue("        ");
        }elsif(pg==3){
            me.MFD_menu_col1.setValue("  - - . - ");
            me.MFD_menu_col2.setValue("  - - - - -");
            me.MFD_menu_col3.setValue("  - . -");
            me.MFD_menu_col4.setValue("- - - - - -");
        }elsif(pg==4){
            me.MFD_menu_col1.setValue("        ");
            me.MFD_menu_col2.setValue("SPEEDS");
            me.MFD_menu_col3.setValue("SPEEDS");
            me.MFD_menu_col4.setValue("        ");
            }elsif(pg==5){
            me.MFD_menu_col1.setValue("  - - -");
            me.MFD_menu_col2.setValue("  - - - ");
            me.MFD_menu_col3.setValue("  - - - ");
            me.MFD_menu_col4.setValue("        ");
            }elsif(pg==6){
            me.MFD_menu_col1.setValue("  - - - ");
            me.MFD_menu_col2.setValue("  - - - ");
            me.MFD_menu_col3.setValue("       ");
            me.MFD_menu_col4.setValue("       ");
        }
        me.MFD_menu_num.setValue(pg);
        me.MFD_menu_line1.setValue(me.MFD_MENU1[pg]);
    },
};
#######################################

var primus = P1000.new("instrumentation/primus1000");
var APoff=props.globals.getNode("/autopilot/locks/passive-mode",1);

var update_p1000 = func {
    primus.update_pfd();
    settimer(update_p1000,0);
    }

setlistener("/sim/signals/fdm-initialized", func {
    APoff.setBoolValue(1);
    props.globals.getNode("instrumentation/primus1000/pfd/serviceable",1).setBoolValue(1);
    props.globals.getNode("instrumentation/primus1000/mfd/serviceable",1).setBoolValue(1);
    props.globals.getNode("instrumentation/primus1000/mfd/mode",1).setValue("normal");
    print("Primus 1000 systems ... check");
    settimer(update_p1000,1);
    });

setlistener("/sim/signals/reinit", func {
    APoff.setBoolValue(1);
    });


setlistener("instrumentation/altimeter/setting-inhg", func(){
    primus.calc_kpa();
    },1,0);

