package org.paasta.container.platform.web.user.users;

import org.paasta.container.platform.web.user.common.RestTemplateService;
import org.paasta.container.platform.web.user.common.model.ResultStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import org.springframework.web.util.CookieGenerator;

import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

import static org.paasta.container.platform.web.user.common.Constants.*;

/**
 * User Service 클래스
 *
 * @author hrjin
 * @version 1.0
 * @since 2020.09.22
 **/
@Service
public class UsersService {

    private final RestTemplateService restTemplateService;

    @Autowired
    public UsersService(RestTemplateService restTemplateService) {
        this.restTemplateService = restTemplateService;
    }

    /**
     * 사용자 회원가입
     *
     * @param users the users
     * @return the ResultStatus
     */
    public ResultStatus registerUser(Users users) {
        return restTemplateService.send(TARGET_CP_API, "/signUp", HttpMethod.POST, users, ResultStatus.class);
    }


    /**
     * 각 namespace별 사용자 목록 조회
     *
     * @param namespace
     * @return
     */
    public UsersList getUsersListByNamespace(String namespace) {
        return restTemplateService.send(TARGET_CP_API, URI_API_USERS_LIST_BY_NAMESPACE.replace("{namespace:.+}", namespace), HttpMethod.GET, null, UsersList.class);
    }



    /**
     * 등록돼있는 사용자들의 이름 목록 조회
     *
     * @return the Map
     */
    public Map<String, List> getUsersNameListByNamespace(String namespace) {
        return restTemplateService.send(TARGET_CP_API, URI_API_USERS_NAMES_LIST_BY_NAMESPACE.replace("{namespace:.+}", namespace), HttpMethod.GET, null, Map.class);
    }

    /**
     * 사용자 로그인
     *
     * @return the ResultStatus
     */
    public ResultStatus loginUser(Users users) {
        return restTemplateService.send(TARGET_CP_API, "/login", HttpMethod.POST, users, ResultStatus.class);
    }

    public List<Users> getUsers(String userId) {
        return restTemplateService.send(TARGET_CP_API, "",HttpMethod.GET, null, List.class);
    }


    /**
     * 전체 사용자 목록을 조회한다.
     *
     * @return
     */
    public UsersList getUsersList() {
        return restTemplateService.send(TARGET_CP_API, URI_API_USERS_LIST, HttpMethod.GET, null, UsersList.class);
    }

}
