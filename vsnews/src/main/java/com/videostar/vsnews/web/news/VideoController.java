package com.videostar.vsnews.web.news;

import com.videostar.vsnews.entity.news.NewsVideo;
import com.videostar.vsnews.service.identify.UserManager;
import com.videostar.vsnews.service.news.ColumnService;
import com.videostar.vsnews.service.news.VideoManager;
import com.videostar.vsnews.util.ConfigXmlReader;
import com.videostar.vsnews.util.FileUtil;
import com.videostar.vsnews.util.UserUtil;
import org.activiti.engine.identity.User;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.UUID;

/**
 * VideoController
 *
 * Created by patchao2000 on 14-8-26.
 */
@Controller
@RequestMapping(value = "/news/video")
public class VideoController {

    private Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    private VideoManager videoManager;

    @Autowired
    private UserManager userManager;

    @Autowired
    private ColumnService columnService;

    @RequestMapping(value = {"upload"})
    public String upload(Model model, HttpSession session) {
        User user = UserUtil.getUserFromSession(session);
        if (user == null || StringUtils.isBlank(user.getId()))
            return "redirect:/login?timeout=true";

        model.addAttribute("user", user);
        model.addAttribute("columnsList", columnService.getUserColumns(userManager.getUserById(user.getId())));

        return "/news/video/upload";
    }
//
//    @RequestMapping(value = "add/{title}/{fileName}/{columnId}/{userId}", method = {RequestMethod.POST})
//    @ResponseBody
//    public String addVideo(@PathVariable("title") String title, @PathVariable("fileName") String fileName,
//                           @PathVariable("columnId") Long columnId, @PathVariable("userId") String userId) {
//        try {
//            if (videoManager.findByTitle(title) != null) {
//                logger.error("video {} already exist", title);
//                return "error";
//            }
//
//            NewsVideo video = new NewsVideo();
//            video.setTitle(title);
//            video.setFileName(fileName);
//            video.setColumnId(columnId);
//            video.setUploadUserId(userId);
//            video.setUploadDate(new Date());
//
//            logger.debug("video created: {} {} {}", video.getId(), video.getTitle(), video.getFileName());
//            return "success";
//        } catch (Exception e) {
//            logger.error("error on create video: {}", title);
//            return "error";
//        }
//    }

    @RequestMapping(value="/upload-start/{title}/{columnId}/{userId}", method = RequestMethod.POST)
    public @ResponseBody LinkedList<FileMeta> upload(@PathVariable("title") String title,
                                                     @PathVariable("columnId") Long columnId,
                                                     @PathVariable("userId") String userId,
                                                     MultipartHttpServletRequest request, HttpServletResponse response) {

        logger.debug("upload start");

        ConfigXmlReader.parseConfig();

        LinkedList<FileMeta> files = new LinkedList<FileMeta>();
        FileMeta fileMeta = null;

        //build an iterator
        Iterator<String> itr = request.getFileNames();
        MultipartFile mpf = null;

        //get single file
        if (itr.hasNext()){

            //get next MultipartFile
            mpf = request.getFile(itr.next());
            logger.debug("file {} uploaded. ", mpf.getOriginalFilename());

            String orgFileName = mpf.getOriginalFilename();

            //create new fileMeta
            fileMeta = new FileMeta();
            fileMeta.setFileName(orgFileName);
            fileMeta.setFileSize(mpf.getSize() / 1024 + " Kb");
            fileMeta.setFileType(mpf.getContentType());

            try {
                fileMeta.setBytes(mpf.getBytes());

                String fileName = UUID.randomUUID().toString() + "." + FileUtil.getFileNameExt(orgFileName);
                // copy file to local disk (make sure the path "e.g. D:/temp/files" exists)
                FileCopyUtils.copy(mpf.getBytes(), new FileOutputStream(ConfigXmlReader.getFileUploadDir() + fileName));

                NewsVideo video = new NewsVideo();
                video.setTitle(title);
                video.setOriginalFileName(orgFileName);
                video.setFileName(fileName);
                video.setColumnId(columnId);
                video.setUploadUserId(userId);
                video.setUploadDate(new Date());
                videoManager.saveVideo(video);

                logger.debug("video created: {} {} {}", video.getId(), video.getTitle(), video.getFileName());

            } catch (IOException e) {
                e.printStackTrace();
            }
            //2.4 add to files
            files.add(fileMeta);
        }

        // result will be like this
        // [{"fileName":"app_engine-85x77.png","fileSize":"8 Kb","fileType":"image/png"},...]
        return files;
    }

//    @RequestMapping(value = "/get/{value}", method = RequestMethod.GET)
//    public void get(HttpServletResponse response,@PathVariable String value){
//        FileMeta getFile = files.get(Integer.parseInt(value));
//        try {
//            response.setContentType(getFile.getFileType());
//            response.setHeader("Content-disposition", "attachment; filename=\""+getFile.getFileName()+"\"");
//            FileCopyUtils.copy(getFile.getBytes(), response.getOutputStream());
//        }catch (IOException e) {
//            e.printStackTrace();
//        }
//    }

//    @RequestMapping(value = "get-by-filename/{fileName:.*}")
//    @ResponseBody
//    public NewsVideo getByFileName(@PathVariable("fileName") String fileName) {
//        NewsVideo video = videoManager.findByFileName(fileName);
//        logger.debug("found video: {}", video);
//        return video;
//    }

    @RequestMapping(value = "check-exists-by-title/{title}")
    @ResponseBody
    public String checkExistsByTitle(@PathVariable("title") String title) {
        if (videoManager.findByTitle(title) != null)
            return "error";
        else
            return "success";
    }
}
