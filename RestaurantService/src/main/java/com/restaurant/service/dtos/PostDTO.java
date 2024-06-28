package com.restaurant.service.dtos;

import com.restaurant.service.entities.Post;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PostDTO {
    private Long id;
    private String title;
    private String image;
    private String content;
    private String created_actor;
    private String create_at;
    private int user_seen;
    private boolean archived; // Thêm trường này

    public static PostDTO fromEntity(Post post) {
        return new PostDTO(
            post.getId(),
            post.getTitle(),
            post.getImage(),
            post.getContent(),
            post.getCreated_actor(),
            post.getCreate_at(),
            post.getUser_seen(),
            post.isArchived() // Đảm bảo rằng bạn đã thêm getter isArchived() trong entity Post của bạn
        );
    }
}
