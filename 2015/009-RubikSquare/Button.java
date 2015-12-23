import java.util.*;
import greenfoot.*;
import java.awt.Color;

public class Button extends Actor {
    int id;
    public Button(String name,int id) {
        this.id=id;
        setImage("C:\\Program Files (x86)\\Greenfoot\\lib\\greenfoot\\imagelib\\symbols\\" + name);
    }
    public void act() {
        if (Greenfoot.mouseClicked(this)) {
            MyWorld world = (MyWorld)this.getWorld();
            if (world.a == -1) {
                world.a = id;
            } else {
                if (world.a != id) world.handle(world.a, id);
                world.a = -1;
            }
        }
    }
}
