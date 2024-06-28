package com.restaurant.service.entities;

import java.text.SimpleDateFormat;
import java.util.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@AllArgsConstructor
@EqualsAndHashCode(callSuper = false)
@Entity
@Table(name = "reservation")
public class Reservation extends AbstractEntity {

	private static final long serialVersionUID = 1L;

	@Column(name = "name")
	private String name;

	@Column(name = "email")
	private String email;

	@Column(name = "phone_number")
	private String phoneNumber;

	@Column(name = "date")
	private String date;

	@Column(name = "start_time")
	private String start_time;

	@Column(name = "end_time")
	private String end_time;

	@Column(name = "person_number")
	private Integer person_number;

	@Column(name = "status")
	private int status = 0;

	@ManyToOne
	@JoinColumn(name = "table_id")
	private TableM tableM;

	public Reservation() {
		super();
	}

//	@Transient
//	public String getDateToString() {
//	    SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
//	    return formatter.format(date);
//	}

}
