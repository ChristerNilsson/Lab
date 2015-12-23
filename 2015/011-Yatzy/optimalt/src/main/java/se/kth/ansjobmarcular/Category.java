package se.kth.ansjobmarcular;

import java.util.Arrays;

public enum Category {

    ONES, TWOS, THREES, FOURS, FIVES, SIXES, PAIR, TWOPAIR, THREEOFAKIND, FOUROFAKIND, SMALLSTRAIGHT, LARGESTRAIGHT, HOUSE, CHANCE, YATZY;
    static Category[] values = Category.values();

    public static int toInt(Category c) {
        return Arrays.binarySearch(values, c);
    }

    public static Category fromInt(int i) {
        return values[i];
    }

    public boolean isUpper() {
        return this == ONES || this == TWOS || this == THREES || this == FOURS || this == FIVES || this == SIXES;
    }
}
