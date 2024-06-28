package com.restaurant.service.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@AllArgsConstructor
@EqualsAndHashCode(callSuper = false)
@Entity
@Table(name = "posts")
public class Post {
	private static final long serialVersionUID = -7437655422342271820L;

	@Id
	@GeneratedValue
	@Column(name = "id")
	private Long id;

	@Column(name = "title", length = 64)
	private String title;

	@Column(name = "image", length = Integer.MAX_VALUE)
	private String image;

	@Column(name = "content", length = Integer.MAX_VALUE)
	private String content;

	@Column(name = "created_actor", length = 1024)
	private String created_actor;

	@Column(name = "create_at", length = 64)
	private String create_at;

	@Column(name = "user_seen")
	private int user_seen;

	@Column(name = "archived")
	private Boolean archived = Boolean.FALSE; // Use Boolean wrapper type


	public Post(String title, String image, String content, String created_actor, String create_at, int user_seen,
			boolean archived) {
		super();
		this.title = title;
		this.image = image;
		this.content = content;
		this.created_actor = created_actor;
		this.create_at = create_at;
		this.user_seen = user_seen;
		this.archived = archived;
	}

	public Post() {

	}

	public boolean isArchived() {
		return archived;
	}

	public void setArchived(boolean archived) {
		this.archived = archived;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getCreated_actor() {
		return created_actor;
	}

	public void setCreated_actor(String created_actor) {
		this.created_actor = created_actor;
	}

	public String getCreate_at() {
		return create_at;
	}

	public void setCreate_at(String create_at) {
		this.create_at = create_at;
	}

	public int getUser_seen() {
		return user_seen;
	}

	public void setUser_seen(int user_seen) {
		this.user_seen = user_seen;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
