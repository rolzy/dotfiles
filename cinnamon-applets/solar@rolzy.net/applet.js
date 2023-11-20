// Import APIs from Cinnamon
const Applet = imports.ui.applet;
const Util = imports.misc.util;     // To run the external program xkill

function MyApplet(orientation, panel_height, instance_id) {
    this._init(orientation, panel_height, instance_id);
}

MyApplet.prototype = {
    __proto__: Applet.TextIconApplet.prototype,

    _init: function(orientation, panel_height, instance_id) {
        Applet.TextIconApplet.prototype._init.call(this, orientation, panel_height, instance_id);

        this.set_applet_icon_name("solar");
        this.set_applet_tooltip(_("Solar Status"));
        this.set_applet_label("Test");
    }
};

// Main function ran by Cinnamon
function main(metadata, orientation, panel_height, instance_id) {
    return new MyApplet(orientation, panel_height, instance_id);
}
