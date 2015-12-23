import java.util.*;
import greenfoot.*;
import java.awt.Color;

public class MyWorld extends World {
    private Button[] arr = new Button[9];
    public int a;
    public MyWorld()     {
        super(600, 400, 1);
        this.arr[0] =  new Button("button-blue.png",0);
        this.arr[1] =  new Button("button-blue.png",1);
        this.arr[2] =  new Button("button-blue.png",2);
        addObject(this.arr[0], 100, 100);
        addObject(this.arr[1], 200, 100);
        addObject(this.arr[2], 300, 100);
        this.arr[3] =  new Button("button-red.png",3);
        this.arr[4] =  new Button("button-red.png",4);
        this.arr[5] =  new Button("button-red.png",5);
        addObject(this.arr[3], 100, 200);
        addObject(this.arr[4], 200, 200);
        addObject(this.arr[5], 300, 200);
        this.arr[6] =  new Button("button-green.png",6);
        this.arr[7] =  new Button("button-green.png",7);
        this.arr[8] =  new Button("button-green.png",8);
        addObject(this.arr[6], 100, 300);
        addObject(this.arr[7], 200, 300);
        addObject(this.arr[8], 300, 300);
        //Handler h = new Handler();
        //addObject(h, -100, -100);
        a = -1;
        solve();
    }

    public void fix(int k1, int k2, int a, int b, int c) {
        if (k1==a && k2==b || k1==b && k2==c) {
            GreenfootImage ai = arr[a].getImage();
            GreenfootImage bi = arr[b].getImage();
            GreenfootImage ci = arr[c].getImage();
            arr[b].setImage(ai);
            arr[c].setImage(bi);
            arr[a].setImage(ci);
        }
        if (k1==c && k2==b || k1==b && k2==a) {
            GreenfootImage ai = arr[a].getImage();
            GreenfootImage bi = arr[b].getImage();
            GreenfootImage ci = arr[c].getImage();
            arr[c].setImage(ai);
            arr[a].setImage(bi);
            arr[b].setImage(ci);
        }
    }

    public void handle(int a, int b) {
        //System.out.println("(" + key + "found" + ")");
        fix(a,b,0,1,2);
        fix(a,b,3,4,5);
        fix(a,b,6,7,8);
        fix(a,b,0,3,6);
        fix(a,b,1,4,7);
        fix(a,b,2,5,8);
    }
    
    //public void act() {
    //    MyWorld world = (MyWorld)this.getWorld();
    //}

    public String mm3(String s, int a, int b, int c) {
        char[] arr = new char[9];
        for (int i=0; i<9; i++) arr[i]= s.charAt(i);
        char tmp = arr[a];
        arr[a] = arr[b];
        arr[b] = arr[c];
        arr[c] = tmp;
        return new String(arr);
    }

    public String makemove3(String s, int i) {
        if (i==0) return mm3(s,0,1,2);
        if (i==1) return mm3(s,3,4,5);
        if (i==2) return mm3(s,6,7,8);
        if (i==3) return mm3(s,2,1,0);
        if (i==4) return mm3(s,5,4,3);
        if (i==5) return mm3(s,8,7,6);
        if (i==6) return mm3(s,0,3,6);
        if (i==7) return mm3(s,1,4,7);
        if (i==8) return mm3(s,2,5,8);
        if (i==9) return mm3(s,6,3,0);
        if (i==10) return mm3(s,7,4,1);
        if (i==11) return mm3(s,8,5,2);
        return "";
    }

    public String mm(String s, int a, int b, int c, int d) {
        char[] arr = new char[16];
        for (int i=0; i<16; i++) arr[i]= s.charAt(i);
        char tmp = arr[a];
        arr[a] = arr[b];
        arr[b] = arr[c];
        arr[c] = arr[d];
        arr[d] = tmp;
        return new String(arr);
    }

    public String makemove(String s, int i) {
        if (i==8) return mm(s,0,1,2,3);
        if (i==9) return mm(s,4,5,6,7);
        if (i==10) return mm(s,8,9,10,11);
        if (i==11) return mm(s,12,13,14,15);

        if (i==12) return mm(s,3,2,1,0);
        if (i==13) return mm(s,7,6,5,4);
        if (i==14) return mm(s,11,10,9,8);
        if (i==15) return mm(s,15,14,13,12);

        if (i==0) return mm(s,0,4,8,12);
        if (i==1) return mm(s,1,5,9,13);
        if (i==2) return mm(s,2,6,10,14);
        if (i==3) return mm(s,3,7,11,15);

        if (i==4) return mm(s,12,8,4,0);
        if (i==5) return mm(s,13,9,5,1);
        if (i==6) return mm(s,14,10,6,2);
        if (i==7) return mm(s,15,11,7,3);
        return "";
    }
    
    private String shorten(String s) {
        String res = "";
        int x = Integer.parseInt(s,2);
        return String.format("%04X",x);
    }
    
    public void solve() {
        Map<String, Integer> hm = new TreeMap<String, Integer>();        
        Queue<String> queue = new LinkedList<String>();
        String alpha = " abcdefghijklmnop";
        queue.add("0000000011111111");
        hm.put("0000000011111111",-1);
        while (queue.size() > 0) {
            String s = queue.remove();
            for (int i=0; i<16; i++) {
                String t = makemove(s,i);
                if (!hm.containsKey(t)) {
                    queue.add(t);
                    hm.put(t,i);
                    //hm.put(t,hm.get(s) + 1);
                }
            }
        }
        
        String name = "C:\\Lab\\2015\\009-RubikSquare\\442.txt";
        java.io.File file = new java.io.File(name);
        file.getParentFile().mkdirs();        
        
        try {
            java.io.PrintWriter writer = new java.io.PrintWriter(name, "UTF-8");
            String buffer = "";
            for (String key : hm.keySet()) {
                int p = 1+hm.get(key);
                System.out.println(p);
                buffer += shorten(key) + alpha.substring(p,p+1) + " ";
                if (buffer.length() > 88) {
                    writer.println(buffer);
                    buffer="";
                }
            }                
            writer.println(buffer);
            writer.close();    
        } catch(java.io.IOException e) {            
            System.out.println("Problem");
        }
        System.out.println(hm.size());
    }
}