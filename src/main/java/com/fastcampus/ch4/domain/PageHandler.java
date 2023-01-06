package com.fastcampus.ch4.domain;

import org.springframework.web.util.UriComponentsBuilder;

public class PageHandler {
//    private int page; // 현재 페이지
//    private int pageSize; // 한 페이지의 크기
//    private String option;
//    private String keyword;

    private SearchCondition sc;

    private int totalCnt;  // 총 게시물 갯수
    private int navSize = 10; // 페이지 내비게이션의 크기
    private int totalPage; // 전체 페이지의 갯수
    private int beginPage; // 내비게이션의 첫 번째 페이지
    private int endPage; // 내비게이션의 마지막 페이지
    private boolean showPrev; // 이전 페이지로 이동하는 링크를 보여줄 것인지의 여부
    private boolean showNext; // 다음 페이지로 이동하는 링크를 보여줄 것인지의 여부

    public SearchCondition getSc() {
        return sc;
    }

    public void setSc(SearchCondition sc) {
        this.sc = sc;
    }

    public int getTotalCnt() {
        return totalCnt;
    }

    public void setTotalCnt(int totalCnt) {
        this.totalCnt = totalCnt;
    }

    public int getNavSize() {
        return navSize;
    }

    public void setNavSize(int navSize) {
        this.navSize = navSize;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public int getBeginPage() {
        return beginPage;
    }

    public void setBeginPage(int beginPage) {
        this.beginPage = beginPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }

    public boolean isShowPrev() {
        return showPrev;
    }

    public void setShowPrev(boolean showPrev) {
        this.showPrev = showPrev;
    }

    public boolean isShowNext() {
        return showNext;
    }

    public void setShowNext(boolean showNext) {
        this.showNext = showNext;
    }

    public PageHandler(int totalCnt, SearchCondition sc) {
        this.totalCnt = totalCnt;
        this.sc = sc;

        doPaging(totalCnt, sc);
    }

//    public PageHandler(int totalCnt, int page) {   // totalCnt, page 값만 지정한 경우에는 pageSize를 10으로 지정
//        this(totalCnt, page, 10);
//    }

    public void doPaging(int totalCnt, SearchCondition sc) {
        this.totalCnt=totalCnt;

        // double로 형변환 이유 = 전체페이지가 10으로 나눈 후 나머지가 있을 때 올림하기 위해
        totalPage = (int)Math.ceil(totalCnt / (double)sc.getPageSize()); // 전체 페이지의 갯수

        beginPage = (sc.getPage()-1) / navSize * navSize + 1;
        endPage = Math.min(beginPage + navSize - 1, totalPage);  // endPage가 10보다 작을 수도 있기 때문에 전체페이지의 갯수와 비교하여 더 작은 값을 사용

        showPrev = beginPage != 1;  // beginPage가 1이 아닐 때만 보여주기
        showNext = endPage != totalPage; // endPage가 totalPage가 아닐 때만 보여주기
    }

    void print() {  // page 내비게이션을 출력하는 메소드
        System.out.println("page = " + sc.getPage());
        System.out.print(showPrev ? "[PREV]" : "");  // 이전 버튼이 참이면 이전 링크를 보여주고 아니면 그냥 공백
        for(int i = beginPage; i <= endPage; i++) {
            System.out.print(i + " ");
        }
        System.out.println(showNext ? " [NEXT]" : "");
    }

    @Override
    public String toString() {
        return "PageHandler{" +
                "sc=" + sc +
                ", totalCnt=" + totalCnt +
                ", navSize=" + navSize +
                ", totalPage=" + totalPage +
                ", beginPage=" + beginPage +
                ", endPage=" + endPage +
                ", showPrev=" + showPrev +
                ", showNext=" + showNext +
                '}';
    }

}
