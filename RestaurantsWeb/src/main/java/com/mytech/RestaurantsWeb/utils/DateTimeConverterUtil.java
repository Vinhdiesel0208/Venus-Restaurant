package com.mytech.RestaurantsWeb.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;

public class DateTimeConverterUtil {
	public static LocalDateTime convertStringToDateTime(String dateString, String timeString) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
		String dateTimeString = dateString + " " + timeString;
		LocalDateTime dateTime = LocalDateTime.parse(dateTimeString, formatter);
		return dateTime;
	}
	  public static String formatDate(String dateStr) throws ParseException {
	        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd");
	        SimpleDateFormat outputFormat = new SimpleDateFormat("dd-MM-yyyy");

	        Date date = inputFormat.parse(dateStr);
	        return outputFormat.format(date);
	    }
	
}
