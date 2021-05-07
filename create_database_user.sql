/* Formatted on 5/6/2021 2:05:41 PM (QP5 v5.362) */
CREATE USER "EI_UTIL" IDENTIFIED BY *********
  DEFAULT TABLESPACE "USERS"
  TEMPORARY TABLESPACE "TEMP"
  PROFILE "DEFAULT"
  ACCOUNT UNLOCK;
GRANT CREATE SESSION TO "EI_UTIL";
GRANT "CONNECT" TO "EI_UTIL";
GRANT "BAN_DEFAULT_CONNECT" TO EI_UTIL;
GRANT "BAN_DEFAULT_M" TO "EI_UTIL";
GRANT "BAN_DEFAULT_Q" TO "EI_UTIL";

ALTER USER "EI_UTIL"
  DEFAULT ROLE ALL EXCEPT BAN_DEFAULT_M , BAN_DEFAULT_Q;

ALTER USER "EI_UTIL"
  GRANT CONNECT THROUGH "BANPROXY";

ALTER USER EI_UTIL
  PROFILE z_sys_ban_app;

INSERT INTO bansecr.guruobj (guruobj_object,
                             guruobj_role,
                             guruobj_userid,
                             guruobj_activity_date,
                             guruobj_user_id)
     VALUES ('GUAGMNU',
             'BAN_DEFAULT_M',
             'EI_UTIL',
             SYSDATE,
             'BANSECR');

INSERT INTO bansecr.guruobj (guruobj_object,
                             guruobj_role,
                             guruobj_userid,
                             guruobj_activity_date,
                             guruobj_user_id)
     VALUES ('API_ABOUT',
             'BAN_DEFAULT_M',
             'EI_UTIL',
             SYSDATE,
             'BANSECR');

--

  SELECT    'insert into bansecr.guruobj values ('''
         || guraobj_object
         || ''',''BAN_DEFAULT_M'',''EI_UTIL'',sysdate,''BANSECR'',null,null,null,null,null);'
    FROM bansecr.guraobj
   WHERE     guraobj_object LIKE 'API\_%' ESCAPE '\'
         AND guraobj_object NOT IN
               (SELECT GURUOBJ_OBJECT
                  FROM bansecr.guruobj
                 WHERE     guruobj_object LIKE 'API%'
                       AND guruobj_userid = 'EI_UTIL')
ORDER BY 1;