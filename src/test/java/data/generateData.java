package data;

public class generateData {
    public static String getEmail() {
        int random = (int)(Math.random() * 100000000);
        return "akbarali" + random + "@tekschool.us";
    }
}
