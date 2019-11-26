package ${table.packageName}.${table.moduleName}.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.gemini.boot.framework.mybatis.entity.LayUiPage;
import com.gemini.boot.framework.web.entity.CommonFailInfo;
import com.gemini.boot.framework.web.entity.Message;
import ${table.packageName}.common.annotation.SysLog;
import ${table.packageName}.${table.moduleName}.po.${table.bigClassName}Po;
import ${table.packageName}.${table.moduleName}.service.${table.bigClassName}Service;
import ${table.packageName}.platform.service.ErrorLogService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * ${table.tableComment}
 *
 * @author ${table.author}
 * @date ${table.createDate}
 */
@Slf4j
@RestController
@RequestMapping("${table.requestMapping}")
public class ${table.bigClassName}Controller {

    @Autowired
    ${table.bigClassName}Service ${table.smallClassName}Service;

    @GetMapping("/gotoList")
    public String gotoList() {
        return "${table.moduleName}/_list";
    }

    @GetMapping
    @ResponseBody
    public Message list(LayUiPage layUiPage, ${table.bigClassName}Po ${table.smallClassName}Po) {
        try {
            QueryWrapper <${table.bigClassName}Po> qw = new QueryWrapper<>();
            if (layUiPage.getPageNum() != 0 && layUiPage.getPageSize() != 0) {
                IPage<${table.bigClassName}Po> list = ${table.smallClassName}Service.page(new Page<>(layUiPage.getPageNum(), layUiPage.getPageSize()), qw);
                return Message.success(list);
            } else {
                List<${table.bigClassName}Po> list = ${table.smallClassName}Service.list(qw);
                return Message.success(list);
            }
        } catch (Exception e) {
            return Message.fail(e.getMessage());
        }
    }

    @GetMapping("/{id}")
    @ResponseBody
    public Message detail(@PathVariable("id") Long id) {
        try {
            if (!StringUtils.isEmpty(id)) {
                ${table.bigClassName}Po ${table.smallClassName}Po = ${table.smallClassName}Service.getById(id);
                return Message.success(${table.smallClassName}Po);
            } else {
                return Message.fail(CommonFailInfo.Id_CAN_NOT_BE_EMPTY);
            }
        } catch (Exception e) {
            return Message.fail(e.getMessage());
        }
    }

    @SysLog("添加${table.tableComment}")
    @PostMapping
    @ResponseBody
    public Message add(@RequestBody ${table.bigClassName}Po po) {
        try {
            if (StringUtils.isEmpty(po.getId())) {
                ${table.smallClassName}Service.insertSync(po, po.getDetailList(), false);
                return Message.success(po);
            } else {
                return Message.fail(CommonFailInfo.Id_ALREADY_EXIST);
            }
        } catch (Exception e) {
            return Message.fail(e.getMessage());
        }
    }

    @SysLog("更新${table.tableComment}")
    @PutMapping
    @ResponseBody
    public Message update(@RequestBody ${table.bigClassName}Po po) {
        try {
            if (!StringUtils.isEmpty(po.getId())) {
                ${table.smallClassName}Service.updateSync(po, po.getDetailList(), false);
                return Message.success(po);
            } else {
                return Message.fail(CommonFailInfo.Id_CAN_NOT_BE_EMPTY);
            }
        } catch (Exception e) {
            return Message.fail(e.getMessage());
        }
    }

    @SysLog("删除${table.tableComment}")
    @DeleteMapping("/{id}")
    @ResponseBody
    public Message delete(@PathVariable("id") Long id) {
        try {
            if (!StringUtils.isEmpty(id)) {
                ${table.smallClassName}Service.deleteByIdSync(id);
                return Message.success(null);
            } else {
                return Message.fail(CommonFailInfo.Id_CAN_NOT_BE_EMPTY);
            }
        } catch (Exception e) {
            return Message.fail(e.getMessage());
        }
    }
            
}