package com.mytech.restaurantportal.exporters;

import java.io.IOException;
import java.util.List;

import org.supercsv.io.CsvBeanWriter;
import org.supercsv.io.ICsvBeanWriter;
import org.supercsv.prefs.CsvPreference;

import com.mytech.restaurantportal.exporters.AbstractExporter;
import com.restaurant.service.entities.User;

import jakarta.servlet.http.HttpServletResponse;

public class UserCsvExporter extends AbstractExporter {
	
	public void export(List<User> listUsers, HttpServletResponse response) throws IOException {
		super.setResponseHeader(response, "text/csv", ".csv", "users_");
		
		String[] csvHeader = {"Id", "Email", "First Name", "Last Name", "Roles", "Created date", "Enabled"};
		String[] fieldMapping = {"id", "email", "firstName", "lastName", "roles", "createdOn", "enabled"};
		
		ICsvBeanWriter csvWriter = new CsvBeanWriter(response.getWriter(), CsvPreference.STANDARD_PREFERENCE);
		csvWriter.writeHeader(csvHeader);
		
		for (User user : listUsers) {
			csvWriter.write(user, fieldMapping);
		}
		
		csvWriter.close();
	}
}
