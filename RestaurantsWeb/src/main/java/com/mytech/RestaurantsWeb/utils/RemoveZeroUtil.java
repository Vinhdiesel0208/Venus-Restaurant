package com.mytech.RestaurantsWeb.utils;

public class RemoveZeroUtil {
	private String removeLeadingZeros(String date) {
	    String[] parts = date.split("-");
	    for (int i = 0; i < parts.length; i++) {
	        parts[i] = parts[i].replaceFirst("^0+(?!$)", "");
	    }
	    return String.join("-", parts);
	}
}
