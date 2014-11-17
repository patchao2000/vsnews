package com.videostar.vsnews.web.util;

import com.videostar.vsnews.entity.news.NewsArticle;
import com.videostar.vsnews.service.news.ArticleManager;
import com.videostar.vsnews.util.WebUtil;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.IOException;

/**
 * DownloadController
 *
 * Created by patchao2000 on 14/11/17.
 */
@Controller
@RequestMapping(value = "/util/download")
public class DownloadController {

//    private Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    protected ArticleManager articleManager;

//    @RequestMapping(value = {"text/{content}"})
//    public ResponseEntity<byte[]> downloadText(@PathVariable("content") String content) throws IOException {
//        HttpHeaders headers = new HttpHeaders();
//        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
//        headers.setContentDispositionFormData("attachment", "article.txt");
//        logger.debug("download text: {}", content);
//        return new ResponseEntity<byte[]>(content.getBytes("UTF-8"), headers, HttpStatus.OK);
//    }

    @RequestMapping(value = {"text/{id}"})
    public ResponseEntity<byte[]> downloadText(@PathVariable("id") Long id) throws IOException {
        NewsArticle article = articleManager.getArticle(id);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", "article.txt");
//        logger.debug("download text: {}", content);
        return new ResponseEntity<byte[]>(WebUtil.getWindowsFormat(WebUtil.htmlRemoveTag(article.getContent()))
                .getBytes("UTF-8"), headers, HttpStatus.OK);
    }
}
