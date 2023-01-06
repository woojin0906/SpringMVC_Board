//package com.fastcampus.ch4.domain;
//
//import org.junit.Test;
//
//import static org.junit.Assert.*;
//
//public class PageHandlerTest {
//    @Test
//    public void test() {
//        PageHandler ph = new PageHandler(250, 1);   // 전체페이지 250, 현재 페이지 1, 페이지 갯수 25
//        ph.print();
//        System.out.println("ph = " + ph);
//
//        assertTrue(ph.getBeginPage()==1);
//        assertTrue(ph.getEndPage()==10);
//
//    }
//
//    @Test
//    public void test2() {
//        PageHandler ph = new PageHandler(250, 11);   // 전체페이지 250, 현재 페이지 11, 페이지 갯수 25
//        ph.print();
//        System.out.println("ph = " + ph);
//
//        assertTrue(ph.getBeginPage()==11);
//        assertTrue(ph.getEndPage()==20);
//
//    }
//
//    @Test
//    public void test3() {
//        PageHandler ph = new PageHandler(255, 25);   // 전체페이지 255, 현재 페이지 25, 페이지 갯수 26
//        ph.print();
//        System.out.println("ph = " + ph);
//
//        assertTrue(ph.getBeginPage()==21);
//        assertTrue(ph.getEndPage()==26);
//
//    }
//
//    @Test
//    public void test4() {
//        PageHandler ph = new PageHandler(255, 10);   // 전체페이지 255, 현재 페이지 25, 페이지 갯수 26
//        ph.print();
//        System.out.println("ph = " + ph);
//
//        assertTrue(ph.getBeginPage()==1);
//        assertTrue(ph.getEndPage()==10);
//
//    }
//}