#GPS KLN90B gps
var GPS = {
    new : func {
    m = { parents : [GPS]};
    m.Menu1 = 3;
    m.Menu2 = 4;
    m.Page1 = 0;
    m.Page2 = 0;
    m.PWR=0;
    m.gps = props.globals.getNode("instrumentation/gps",1);
    m.gps_annun = props.globals.getNode("instrumentation/gps-annunciator",1);
    m.serviceable = m.gps.getNode("serviceable");
    m.serviceable.setBoolValue(0);
    m.pwr=props.globals.getNode("/systems/electrical/outputs/gps",1);
    m.pwr.setDoubleValue(0);
    m.dtrk=m.gps.getNode("wp/wp[1]/desired-course-deg",1);

    m.LHstring0 = m.gps_annun.getNode("LHmode-string[0]",1);
    m.LHstring0.setValue("");
    m.LHstring1 = m.gps_annun.getNode("LHmode-string[1]",1);
    m.LHstring1.setValue("");
    m.LHstring2 = m.gps_annun.getNode("LHmode-string[2]",1);
    m.LHstring2.setValue("");
    m.LHstring3 = m.gps_annun.getNode("LHmode-string[3]",1);
    m.LHstring3.setValue("");
    m.LHstring4 = m.gps_annun.getNode("LHmode-string[4]",1);
    m.LHstring4.setValue("");
    m.LHstring5 = m.gps_annun.getNode("LHmode-string[5]",1);
    m.LHstring5.setValue("");
    m.LHstring6 = m.gps_annun.getNode("LHmode-string[6]",1);
    m.LHstring6.setValue("");

    m.RHstring0 = m.gps_annun.getNode("RHmode-string[0]",1);
    m.RHstring0.setValue("");
    m.RHstring1 = m.gps_annun.getNode("RHmode-string[1]",1);
    m.RHstring1.setValue("");
    m.RHstring2 = m.gps_annun.getNode("RHmode-string[2]",1);
    m.RHstring2.setValue("");
    m.RHstring3 = m.gps_annun.getNode("RHmode-string[3]",1);
    m.RHstring3.setValue("");
    m.RHstring4 = m.gps_annun.getNode("RHmode-string[4]",1);
    m.RHstring4.setValue("");
    m.RHstring5 = m.gps_annun.getNode("RHmode-string[5]",1);
    m.RHstring5.setValue("");
    m.RHstring6 = m.gps_annun.getNode("RHmode-string[6]",1);
    m.RHstring6.setValue("");

    m.slaved = props.globals.getNode("instrumentation/nav/slaved-to-gps",1);
    m.slaved.setBoolValue(1);
    m.legmode = m.gps.getNode("leg-mode",1);
    m.legmode.setBoolValue(1);
    m.appr = m.gps.getNode("approach-active",1);
    m.appr.setBoolValue(0);
return m;
    },
##################
    draw_display : func(){
        if(me.PWR == 0){
            me.LHstring0.setValue("");
            me.LHstring1.setValue("");
            me.LHstring2.setValue("");
            me.LHstring3.setValue("");
            me.LHstring4.setValue("");
            me.LHstring5.setValue("");
            me.LHstring6.setValue("POWER OFF");
            me.RHstring0.setValue("");
            me.RHstring1.setValue("");
            me.RHstring2.setValue("");
            me.RHstring3.setValue("");
            me.RHstring4.setValue("");
            me.RHstring5.setValue("");
            me.RHstring6.setValue("POWER OFF");
        }else{
        me.setmode1();
        me.setmode2();
        }
    },
##################
    power_up : func(){
        var tmp=me.serviceable.getValue();
        tmp=1-tmp;
        me.serviceable.setBoolValue(tmp);
        me.get_power();
    },
##################
    get_power : func(){
        if(me.pwr.getValue()>5){
        me.PWR=1;
        }else{
        me.PWR=0;
        }
    },
##################
    setmode1: func(){
        if(me.Menu1 == 0){
            me.set_TRI1();
        }elsif(me.Menu1 == 1){
            me.set_MOD1();
        }elsif(me.Menu1 == 2){
            me.set_FPL1();
        }elsif(me.Menu1 == 3){
            me.set_NAV1();
        }elsif(me.Menu1 == 4){
            me.set_CAL1();
        }elsif(me.Menu1 == 5){
            me.set_STA1();
        }elsif(me.Menu1 == 6){
            me.set_SET1();
        }elsif(me.Menu1 == 7){
            me.set_OTH1();
        }
    },
##################
    setmode2: func(){
        if(me.Menu2 == 0){
            me.set_CTR2();
        }elsif(me.Menu2 == 1){
            me.set_REF2();
        }elsif(me.Menu2 == 2){
            me.set_ACT2();
        }elsif(me.Menu2 == 3){
            me.set_DT2();
        }elsif(me.Menu2 == 4){
            me.set_NAV2();
        }elsif(me.Menu2 == 5){
            me.set_APT2();
        }elsif(me.Menu2 == 6){
            me.set_VOR2();
        }elsif(me.Menu2 == 7){
            me.set_NDB2();
        }elsif(me.Menu2 == 8){
            me.set_INT2();
        }elsif(me.Menu2 == 9){
            me.set_SUP2();
        }
    },

################################
#######Update Pages ############
###############################
####### LEFT MENU ###########
#############################
    set_TRI1: func {
        var num=me.Page1+1;
        me.LHstring6.setValue("TRI "~num);
    },
################
    set_MOD1: func {
        var num=me.Page1+1;
        me.LHstring6.setValue("MOD "~num);
    },
###############
    set_FPL1: func {
        var num=me.Page1+1;
        me.LHstring6.setValue("FPL "~num);
    },
################
    set_NAV1: func {
        var num=me.Page1+1;
        me.LHstring6.setValue("NAV "~num);
        var buf="";
        var ID=getprop("instrumentation/gps/wp/wp/ID");
        if(ID==nil)ID="D";
        var ID2=getprop("instrumentation/gps/wp/wp[1]/ID");
        if(ID2==nil)ID2=" ";
        buf = sprintf("   %s > %s",ID,ID2);
        me.LHstring0.setValue(buf);
        me.LHstring1.setValue("* * * * * * * * * * *");
        var DIS=getprop("instrumentation/gps/wp/wp[1]/distance-nm");
        buf = sprintf("DIS     %4.0fNM",DIS);
        me.LHstring2.setValue(buf);
        var GS=getprop("velocities/groundspeed-kt");
        buf = sprintf("GS     %3.0fKT",GS);
        me.LHstring3.setValue(buf);
        var ETE=getprop("instrumentation/gps/wp/wp[1]/TTW");
        buf = sprintf("ETE     %s",ETE);
        me.LHstring4.setValue(buf);
        var BRG=getprop("instrumentation/gps/wp/wp[1]/bearing-mag-deg");
        buf = sprintf("BRG     %3.0f",BRG);
        me.LHstring5.setValue(buf);
    },
#################
    set_CAL1: func {
        var num=me.Page1+1;
        me.LHstring6.setValue("CAL "~num);
    },
#################
    set_STA1: func {
        var num=me.Page1+1;
        me.LHstring6.setValue("STA "~num);
    },
##################
    set_SET1: func {
        var num=me.Page1+1;
        me.LHstring6.setValue("SET "~num);
    },
##################
    set_OTH1: func {
        var num=me.Page1+1;
        me.LHstring6.setValue("OTH "~num);
    },
##############################
####### RIGHT MENU ###########
##############################
    set_CTR2: func {
        var num=me.Page2+1;
        me.RHstring6.setValue("CTR "~num);
    },
#################
    set_REF2: func {
        var num=me.Page2+1;
        me.RHstring6.setValue("REF "~num);
    },
################
    set_ACT2: func {
        var num=me.Page2+1;
        me.RHstring6.setValue("ACT "~num);
    },
#################
    set_DT2: func {
        var num=me.Page2+1;
        me.RHstring6.setValue("D/T "~num);
    },
################
    set_NAV2: func {
        var num=me.Page2+1;
        me.RHstring6.setValue("NAV "~num);
    },
###################
    set_APT2: func {
        var num=me.Page2+1;
        me.RHstring6.setValue("APT "~num);
    },
###################
    set_VOR2: func {
        var num=me.Page2+1;
        me.RHstring6.setValue("VOR "~num);
    },
##################
    set_NDB2: func {
        var num=me.Page2+1;
        me.RHstring6.setValue("NDB "~num);
    },
#################
    set_INT2: func {
        var num=me.Page2+1;
        me.RHstring6.setValue("INT "~num);
    },
##################
    set_SUP2: func {
        var num=me.Page2+1;
        me.RHstring6.setValue("SUP "~num);
    },
##################
##################
    GPSappr : func {
        me.legmode.setBoolValue(0);
        me.slaved.setBoolValue(0);
        if(me.appr.getBoolValue()){
            me.appr.setBoolValue(0);
        }else{
            me.appr.setBoolValue(1);
        }
},
##################
    GPScrs : func {
        me.appr.setBoolValue(0);
        if(me.legmode.getBoolValue()){
            me.legmode.setBoolValue(0);
            me.slaved.setBoolValue(0);
        }else{
            me.legmode.setBoolValue(1);
            me.slaved.setBoolValue(1);
        }
},
##################
    lh_menu : func (test){
        if(me.PWR != 0){
            me.Menu1 +=test;
            if(me.Menu1 > 7)me.Menu1 -= 8;
            if(me.Menu1 < 0)me.Menu1 += 8;
        }
    },
##################
    lh_page : func (test){
        if(me.PWR != 0){
            me.Page1 +=test;
            if(me.Page1 > 7)me.Page1 -= 8;
            if(me.Page1 < 0)me.Page1 += 8;
        }
    },
##################
    rh_menu : func (test){
        if(me.PWR != 0){
            me.Menu2 +=test;
            if(me.Menu2 > 7)me.Menu2 -= 8;
            if(me.Menu2 < 0)me.Menu2 += 8;
        }
    },
##################
    rh_page : func (test){
        if(me.PWR != 0){
            me.Page2 +=test;
            if(me.Page2 > 7)me.Page2 -= 8;
            if(me.Page2 < 0)me.Page2 += 8;
        }
    },
#################
    direct_to : func {
        if(me.PWR != 0){
            setprop("instrumentation/gps/wp/wp[0]/waypoint-type","");
            setprop("instrumentation/gps/wp/wp[0]/ID","");
            setprop("instrumentation/gps/wp/wp[0]/name","");
            setprop("instrumentation/gps/wp/wp[0]/latitude-deg",getprop("position/latitude-deg"));
            setprop("instrumentation/gps/wp/wp[0]/longitude-deg",getprop("position/longitude-deg"));
        }
    }
};
#########################################################

var Gps = GPS.new();

setlistener("sim/signals/fdm-initialized", func {
    setprop("instrumentation/gps/wp/wp/ID",getprop("sim/tower/airport-id"));
    setprop("instrumentation/gps/wp/wp/waypoint-type","airport");
    print("KLN-90B GPS  ...Check");
    settimer(update_gps,5);
    });

var update_gps = func {
    Gps.get_power();
    Gps.draw_display();
    settimer(update_gps,0);
}

