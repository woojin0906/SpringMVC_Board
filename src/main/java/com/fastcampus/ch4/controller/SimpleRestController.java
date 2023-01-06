package com.fastcampus.ch4.controller;

import com.fastcampus.ch4.domain.*;
import com.fastcampus.ch4.service.CommentService;
import org.checkerframework.checker.units.qual.C;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.*;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class SimpleRestController {
//    @GetMapping("/ajax")
//    public String ajax() {
//        return "ajax";  // 뷰이름
//    }
    @Autowired
    CommentService commentService;

    @GetMapping("/test")
    public String test2(Integer bno, Model m) {
        try {
            int commentDto = commentService.getCount(bno);
            m.addAttribute(commentDto);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "comment";  // 뷰이름
    }

    @GetMapping("/test2")
    public String test() {
        return "test2";  // 뷰이름
    }

    @PostMapping("/send")
//    @ResponseBody
    public Person test(@RequestBody Person p) {  // 자바 스크립트 객체로 보낸게 자바 객체로 변환됨
        System.out.println("p = " + p);
        p.setName("ABC");
        p.setAge(p.getAge() + 10);

        return p;
    }

    @PostMapping("/send2")
//    @ResponseBody
    public Person test2(@RequestBody Person p) {  // 자바 스크립트 객체로 보낸게 자바 객체로 변환됨
        System.out.println("p = " + p);
        p.setName("ABC");
        p.setAge(p.getAge() + 10);

        return p;
    }
}