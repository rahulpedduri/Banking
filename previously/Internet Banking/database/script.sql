CREATE TABLE  "ACCNO_USERNAME" 
   (	"USERNAME" VARCHAR2(20), 
	"ACCNO" VARCHAR2(20), 
	 PRIMARY KEY ("USERNAME") ENABLE, 
	 UNIQUE ("ACCNO") ENABLE
   ) ;CREATE TABLE  "APPLICATION_FORM" 
   (	"APPLICATION_NO" NUMBER(10,0), 
	"FIRST_NAME" VARCHAR2(25), 
	"LAST_NAME" VARCHAR2(20), 
	"DOB" DATE, 
	"ADDRESS" VARCHAR2(50), 
	"EMAIL" VARCHAR2(20), 
	"PHONE" NUMBER(15,0), 
	"USERNAME" VARCHAR2(25), 
	"PAN_NO" CHAR(10), 
	"PHOTO" VARCHAR2(100), 
	"SECURITY_QUES" VARCHAR2(75), 
	"SECURITY_ANS" VARCHAR2(50), 
	"EMAIL_VERIFIED" CHAR(3), 
	"PASSWORD" VARCHAR2(30), 
	"TYPE_OF_USER" VARCHAR2(10), 
	 CONSTRAINT "EMAIL_VER_CONS" CHECK (email_verified IN ('yes','no')) ENABLE, 
	 PRIMARY KEY ("APPLICATION_NO") ENABLE, 
	 UNIQUE ("USERNAME") ENABLE
   ) ;CREATE TABLE  "AUTO_DEBIT" 
   (	"AUTODEBIT_ID" NUMBER(5,0), 
	"USERNAME" VARCHAR2(20), 
	"AMT_PER_INSTALLMENT" NUMBER(10,2), 
	"START_DATE" TIMESTAMP (6), 
	"END_DATE" TIMESTAMP (6), 
	"PAY_DATE" TIMESTAMP (6), 
	"NO_OF_INSTALLMENTS" NUMBER(4,0), 
	"ANY_COMMENT" VARCHAR2(100), 
	"NAME" VARCHAR2(25), 
	"AMOUNT_TO_BE_PAID" NUMBER(20,2), 
	"AMOUNT_PAID" NUMBER(20,2), 
	 PRIMARY KEY ("AUTODEBIT_ID") ENABLE
   ) ;CREATE TABLE  "CREDIT_ENABLE_DETAILS" 
   (	"USERNAME" VARCHAR2(20), 
	"SOURCES_OF_INCOME" VARCHAR2(10), 
	"PROFESSION" VARCHAR2(20), 
	"ANNUAL_INCOME" FLOAT(126), 
	"SURITY" VARCHAR2(20), 
	"VERIFIED" NUMBER, 
	 CONSTRAINT "CREDIT_ENABLE_DETAILS_CON" PRIMARY KEY ("USERNAME") ENABLE, 
	 CONSTRAINT "VERIFY_COLUMN_CON" CHECK ("VERIFIED"='yes' OR "VERIFIED"='no') ENABLE
   ) ;CREATE TABLE  "CREDIT_HISTORY" 
   (	"USERNAME" VARCHAR2(20), 
	"CREDIT_AMT" NUMBER(10,0), 
	"TIME_OF_TRANS" TIMESTAMP (6), 
	"STATUS" VARCHAR2(20), 
	"CREDIT_ID" NUMBER(6,0), 
	 CONSTRAINT "CREDIT_CON" PRIMARY KEY ("CREDIT_ID") ENABLE, 
	 CONSTRAINT "STATUS_CON" CHECK ( "STATUS" in('credit','debit')) ENABLE
   ) ;CREATE TABLE  "DETAILS" 
   (	"BANK_AC_NO" NUMBER(10,0), 
	"FIRST_NAME" VARCHAR2(25), 
	"LAST_NAME" VARCHAR2(20), 
	"DOB" DATE, 
	"ADDRESS" VARCHAR2(50), 
	"EMAIL" VARCHAR2(20), 
	"PHONE" NUMBER(15,0), 
	"USERNAME" VARCHAR2(25), 
	"PAN_NO" CHAR(10), 
	"PHOTO" VARCHAR2(100), 
	"BALANCE" NUMBER(10,2), 
	"STATUS" CHAR(8), 
	"CREDIT_ENABLED" CHAR(3), 
	"CREDIT_LIMIT" NUMBER, 
	"CREDIT" NUMBER, 
	"APPLICATION_NO" NUMBER(10,0), 
	 CONSTRAINT "STATUS_CONS" CHECK (status IN ('active','inactive')) ENABLE, 
	 CONSTRAINT "CREDIT_ENABLED_CONS" CHECK (credit_enabled IN ('yes','no')) ENABLE, 
	 PRIMARY KEY ("BANK_AC_NO") ENABLE, 
	 UNIQUE ("USERNAME") ENABLE
   ) ;CREATE TABLE  "PENDING_TRANS" 
   (	"PENDING_ID" NUMBER(6,0), 
	"USERNAME" VARCHAR2(20), 
	"START_DATE" TIMESTAMP (6), 
	"END_DATE" TIMESTAMP (6), 
	"PAY_DATE" TIMESTAMP (6), 
	"NO_OF_INSTALLMENTS" NUMBER(20,0), 
	"ANY_COMMENT" VARCHAR2(100), 
	"FULL_NAME" VARCHAR2(25), 
	"AMOUNT_TO_BE_PAID" VARCHAR2(10), 
	"AMOUNT_PAID" VARCHAR2(25), 
	"ALLOWED" CHAR(3), 
	"INSTALLMENTS_COMPLETED" NUMBER, 
	 PRIMARY KEY ("PENDING_ID") ENABLE, 
	 CONSTRAINT "ALLOWED_CON" CHECK ( "ALLOWED" in ('yes','no')) ENABLE
   ) ;CREATE TABLE  "REQUEST_EDIT_DETAILS" 
   (	"USERNAME" VARCHAR2(20), 
	"DETAILS" VARCHAR2(10), 
	"TIME_OF_TRANS" TIMESTAMP (6), 
	"VALUE" VARCHAR2(20)
   ) ;CREATE TABLE  "SECURITY" 
   (	"USERNAME" VARCHAR2(20), 
	"PASSWORD" VARCHAR2(20), 
	"SECURITY_QUES" VARCHAR2(75), 
	"SECURITY_ANS" VARCHAR2(50), 
	"TYPE_OF_USER" VARCHAR2(20), 
	 PRIMARY KEY ("USERNAME") ENABLE
   ) ;CREATE TABLE  "SECURITY_EDIT_DETAILS" 
   (	"USERNAME" VARCHAR2(20), 
	"DETAILS" VARCHAR2(10), 
	"TIME_OF_TRANS" TIMESTAMP (6), 
	"VALUE" VARCHAR2(20)
   ) ;CREATE TABLE  "TEMP_EDIT_DETAILS" 
   (	"USERNAME" VARCHAR2(20), 
	"DETAILS" VARCHAR2(10), 
	"DATETIME" TIMESTAMP (6), 
	"VALUE" VARCHAR2(20)
   ) ;CREATE TABLE  "TRANS_HISTORY" 
   (	"USERNAME" VARCHAR2(20), 
	"TRANS_TYPE" NUMBER(10,0), 
	"TIME_OF_TRANS" TIMESTAMP (6), 
	"BALANCE_AFTER" NUMBER(10,2), 
	"BALANCE_BEFORE" NUMBER(10,2), 
	"ANY_COMMENT" VARCHAR2(100), 
	"FULL_NAME" VARCHAR2(25), 
	"TARGET_AC_NO" NUMBER(15,0), 
	"AUTO_DEBIT" VARCHAR2(10), 
	"PAID_BY" CHAR(7), 
	"TRANS_ID" NUMBER(12,0) NOT NULL ENABLE, 
	"AMOUNT" NUMBER, 
	 CONSTRAINT "AUTO_DEBIT_CONS" CHECK (auto_debit IN ('yes','no')) ENABLE, 
	 CONSTRAINT "PAID_BY_CONS" CHECK (paid_by IN ('debit','credit')) ENABLE, 
	 CONSTRAINT "TRANS_ID_CON" PRIMARY KEY ("TRANS_ID") ENABLE
   ) ;CREATE TABLE  "VERIFICATION_CODE" 
   (	"EMAIL" VARCHAR2(20), 
	"CODE" VARCHAR2(10), 
	"DATETIME" TIMESTAMP (6), 
	"REASON" VARCHAR2(20)
   ) ;
Rem No function found to generate DDL.
CREATE UNIQUE INDEX  "SYS_C007096" ON  "APPLICATION_FORM" ("APPLICATION_NO") 
  ;CREATE UNIQUE INDEX  "SYS_C007097" ON  "APPLICATION_FORM" ("USERNAME") 
  ;CREATE UNIQUE INDEX  "SYS_C007100" ON  "DETAILS" ("BANK_AC_NO") 
  ;CREATE UNIQUE INDEX  "SYS_C007101" ON  "DETAILS" ("USERNAME") 
  ;CREATE UNIQUE INDEX  "TRANS_ID_CON" ON  "TRANS_HISTORY" ("TRANS_ID") 
  ;CREATE UNIQUE INDEX  "SYS_C007105" ON  "AUTO_DEBIT" ("AUTODEBIT_ID") 
  ;CREATE UNIQUE INDEX  "SYS_C007106" ON  "PENDING_TRANS" ("PENDING_ID") 
  ;CREATE UNIQUE INDEX  "CREDIT_ENABLE_DETAILS_CON" ON  "CREDIT_ENABLE_DETAILS" ("USERNAME") 
  ;CREATE UNIQUE INDEX  "SYS_C007134" ON  "SECURITY" ("USERNAME") 
  ;CREATE UNIQUE INDEX  "CREDIT_CON" ON  "CREDIT_HISTORY" ("CREDIT_ID") 
  ;CREATE UNIQUE INDEX  "SYS_C007135" ON  "ACCNO_USERNAME" ("USERNAME") 
  ;CREATE UNIQUE INDEX  "SYS_C007136" ON  "ACCNO_USERNAME" ("ACCNO") 
  ;
Rem No package found to generate DDL.
CREATE OR REPLACE PROCEDURE  "CHANGE_SECURITY_PASSWORD" 
(old IN VARCHAR2,
new IN VARCHAR2,
usern IN VARCHAR2,
report OUT VARCHAR2)
is
    temp varchar2(25);
    opvar varchar2(25);
begin
 temp := rpad (new, (trunc(length(new)/8)+1)*8, chr(0));
    dbms_obfuscation_toolkit.DESEncrypt(input_string => temp,
    key_string => '123456789', encrypted_string => opvar);
update security set password=opvar where username=usern;

report:='success';
commit;
EXCEPTION
  WHEN OTHERS THEN
    report:='failure';
    ROLLBACK;

end;
/
/
CREATE OR REPLACE PROCEDURE  "CREATE_BANK_ACC" 
(appno IN number,bal IN number)
is
    email_ver char(3); 
ac_no number(10);
usern varchar(25);
begin   
insert into security(username,security_ques,security_ans,type_of_user) 
    select username,security_ques,security_ans,type_of_user 
    from application_form where application_no=appno;

insert into details(username,first_name,last_name,dob,address,email,phone,pan_no,photo,application_no) 
    select username,first_name,last_name,dob,address,email,phone,pan_no,photo,application_no
    from application_form where application_no=appno;

select email_verified into email_ver from application_form where application_no=appno;

if email_ver in('no') then
    update details set status='inactive' where application_no=appno;
else
    update details set status='active' where application_no=appno;
end if;

update details set balance=(bal),credit=0,credit_limit=0,credit_enabled='no' 
     where application_no=appno;
insert into accno_username(username,accno)
       select username,bank_ac_no from details where application_no=appno;
commit;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;

end;
/
/
CREATE OR REPLACE PROCEDURE  "DEPOSIT" 
(accno IN NUMBER,
amt IN NUMBER,
any_comm IN VARCHAR2 default null,
name_of_trans IN VARCHAR2 default null,
report OUT VARCHAR2)
is
creditnow number;
balnow number;
bal_after_credit number;
usern varchar2(25);   
begin
    select balance,credit into balnow,creditnow from details where bank_ac_no=accno;
select username into usern from accno_username where accno=accno; 

if creditnow = 0 then
    insert into trans_history(username,trans_type,time_of_trans,
        balance_before,any_comment,full_name,auto_debit,paid_by,amount) 
    values(usern,'deposit',sysdate,balnow,any_comm,name_of_trans,'no','debit',amt);
    
    update details set balance=(balnow+amt);
    update trans_history set balance_after=(balnow+amt);

end if;
if creditnow > 0 then
    bal_after_credit:=amt-creditnow;
  if bal_after_credit > 0 then
      insert into credit_history(username,credit_amt,time_of_trans,status)
      values(usern,0,sysdate,'debit');

      insert into trans_history(username,trans_type,time_of_trans,
        balance_before,any_comment,full_name,auto_debit,paid_by,amount) 
    values(usern,'deposit',sysdate,balnow,any_comm,name_of_trans,'no','debit',amt);
      
      update details set credit=0,balance=(balnow+bal_after_credit);
      update trans_history set balance_after=(balnow+bal_after_credit);
      
      
  else
      insert into credit_history(username,credit_amt,time_of_trans,status)
      values(usern,(creditnow-amt),sysdate,'debit');
      update details set credit=(creditnow-amt); 
      
  
  end if;
    
end if;
report:='success';
commit;
EXCEPTION
  WHEN OTHERS THEN
    report:='failure';
    ROLLBACK;

 
end;
/
/
CREATE OR REPLACE PROCEDURE  "DROP_ME" 
(pass IN VARCHAR2)
is

temp varchar2(100);
 opvar varchar2(2000);
begin
temp := rpad (pass, (trunc(length(pass)/8)+1)*8, chr(0));
dbms_obfuscation_toolkit.DESEncrypt(input_string => temp,
    key_string => '123456789', encrypted_string => opvar);
dbms_output.put_line('Enc Output :'||opvar);
dbms_obfuscation_toolkit.DESdEcrypt(input_string => opvar,
    key_string => '123456789', decrypted_string => opvar );
dbms_output.put_line('Dec Output :'||pass );
end;
/
/
CREATE OR REPLACE PROCEDURE  "MONEY_TRANSFER" 
(accno IN NUMBER,
target IN NUMBER,
amt IN NUMBER,
any_comm IN VARCHAR2 default null,
name_of_trans IN VARCHAR2 default null,
report OUT VARCHAR2)
is
creditnow number;
creditlim number;
crediten char(3);
balnow number;
usern varchar2(25); 

targetbal_after_credit number;
targetcreditnow number;
targetbalnow number;
targetusern varchar2(25);
begin
    select balance,credit,credit_limit,credit_enabled 
    into balnow,creditnow,creditlim,crediten from details where bank_ac_no=accno;
select username into usern from accno_username where accno=accno; 

select balance,credit 
    into targetbalnow,targetcreditnow from details where bank_ac_no=target;
select username into targetusern from accno_username where accno=target; 


if (balnow-amt)>1000 then
 insert into trans_history(username,trans_type,time_of_trans,balance_before,
        any_comment,full_name,auto_debit,paid_by,target_ac_no,amount) 
        values(usern,'a/c transfer',sysdate,balnow,any_comm,name_of_trans,
        'no','debit',target,amt);
    update details set balance=(balnow-amt);
    update trans_history set balance_after=(balnow-amt);


if targetcreditnow = 0 then
    insert into trans_history(username,trans_type,time_of_trans,
        balance_before,any_comment,full_name,auto_debit,paid_by,amount) 
    values(targetusern,'a/c transfer',sysdate,targetbalnow,any_comm,
        name_of_trans,'no','debit',amt);
    
    update details set balance=(targetbalnow+amt);
    update trans_history set balance_after=(targetbalnow+amt);

end if;

if targetcreditnow > 0 then
    targetbal_after_credit:=amt-targetcreditnow;
  if targetbal_after_credit > 0 then
      insert into credit_history(username,credit_amt,time_of_trans,status)
      values(targetusern,0,sysdate,'debit');

      insert into trans_history(username,trans_type,time_of_trans,
        balance_before,any_comment,full_name,auto_debit,paid_by,amount) 
    values(targetusern,'deposit',sysdate,targetbalnow,any_comm,name_of_trans,
        'no','debit',amt);
      
      update details set credit=0,balance=(targetbalnow+targetbal_after_credit);
      update trans_history set balance_after=(targetbalnow+targetbal_after_credit);
      
      
  else
      insert into credit_history(username,credit_amt,time_of_trans,status)
      values(targetusern,(targetcreditnow-amt),sysdate,'debit');
      update details set credit=(targetcreditnow-amt); 
      
  
  end if;
end if;



else
if crediten in('yes') then
    if (creditnow+amt)<creditlim then
       insert into trans_history(username,trans_type,time_of_trans,balance_before,
        balance_after,any_comment,full_name,auto_debit,paid_by,target_ac_no) 
        values(usern,'a/c transfer',sysdate,balnow,balnow,any_comm,name_of_trans,
        'no','credit',target);
    insert into credit_history(username,credit_amt,time_of_trans,status) 
        values(usern,(amt+creditnow),sysdate,'credit');
    update details set credit=(creditnow+amt);

if targetcreditnow = 0 then
    insert into trans_history(username,trans_type,time_of_trans,
        balance_before,any_comment,full_name,auto_debit,paid_by,amount) 
    values(targetusern,'a/c transfer',sysdate,targetbalnow,any_comm,
        name_of_trans,'no','debit',amt);
    
    update details set balance=(targetbalnow+amt);
    update trans_history set balance_after=(targetbalnow+amt);

end if;

if targetcreditnow > 0 then
    targetbal_after_credit:=amt-targetcreditnow;
  if targetbal_after_credit > 0 then
      insert into credit_history(username,credit_amt,time_of_trans,status)
      values(targetusern,0,sysdate,'debit');

      insert into trans_history(username,trans_type,time_of_trans,
        balance_before,any_comment,full_name,auto_debit,paid_by,amount) 
    values(targetusern,'deposit',sysdate,targetbalnow,any_comm,name_of_trans,
        'no','debit',amt);
      
      update details set credit=0,balance=(targetbalnow+targetbal_after_credit);
      update trans_history set balance_after=(targetbalnow+targetbal_after_credit);
      
      
  else
      insert into credit_history(username,credit_amt,time_of_trans,status)
      values(targetusern,(targetcreditnow-amt),sysdate,'debit');
      update details set credit=(targetcreditnow-amt); 
      
  
  end if;
end if;
  else
      report:='failure';
    end if;
end if;

end if;



report:='success';
commit;
EXCEPTION
  WHEN OTHERS THEN
    report:='failure';
    ROLLBACK;

 
end;
/
/
CREATE OR REPLACE PROCEDURE  "WITHDRAW" 
(accno IN NUMBER,
amt IN NUMBER,
any_comm IN VARCHAR2 default null,
name_of_trans IN VARCHAR2 default null,
report OUT VARCHAR2)
is
balnow number;
usern varchar2(25);   
begin
    select balance into balnow from details where bank_ac_no=accno;
select username into usern from accno_username where accno=accno; 

if (balnow-amt) >= 1000 then
    insert into trans_history(username,trans_type,time_of_trans,balance_before,
        any_comment,full_name,auto_debit,paid_by,amount) 
        values(usern,'withdraw',sysdate,balnow,any_comm,name_of_trans,'no','debit',amt);
    update details set balance=(balnow-amt);
    update trans_history set balance_after=(balnow-amt);

end if;
report:='success';
commit;
EXCEPTION
  WHEN OTHERS THEN
    report:='failure';
    ROLLBACK;

 
end;
/
/
 CREATE SEQUENCE   "SEQ_APP_FORM"  MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1000000024 CACHE 24 NOORDER  NOCYCLE ; CREATE SEQUENCE   "SEQ_AUTO_DEBIT"  MINVALUE 1 MAXVALUE 99999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ; CREATE SEQUENCE   "SEQ_BANK_ACC"  MINVALUE 100 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 100 CACHE 24 NOORDER  NOCYCLE ; CREATE SEQUENCE   "SEQ_CREDIT_HIST"  MINVALUE 1 MAXVALUE 999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ; CREATE SEQUENCE   "SEQ_PEND_TRANS"  MINVALUE 1 MAXVALUE 99999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ; CREATE SEQUENCE   "SEQ_TRANS_HIST"  MINVALUE 1 MAXVALUE 999999999999 INCREMENT BY 1 START WITH 1 CACHE 50 NOORDER  NOCYCLE ;
Rem No synonym found to generate DDL.
CREATE OR REPLACE TRIGGER  "TRIG_BEF_APP_FORM" 
before insert on application_form
for each row
declare
    max_id number;
    cur_seq number;
begin
    if :new.application_no is null then
        -- No ID passed, get one from the sequence
        select seq_app_form.nextval into :new.application_no from dual;
    else
        -- ID was set via insert, so update the sequence
        select greatest(nvl(max(application_no),0), :new.application_no) 
        into max_id from application_form;
        select seq_app_form.nextval into cur_seq from dual;
        while cur_seq < max_id
        loop
            select seq_app_form.nextval into cur_seq from dual;
        end loop;
    end if;
end;
/
ALTER TRIGGER  "TRIG_BEF_APP_FORM" ENABLE;CREATE OR REPLACE TRIGGER  "TRIG_BEF_AUTO_DEBIT" 
before insert on auto_debit
for each row
declare
    max_id number;
    cur_seq number;
begin
    if :new.autodebit_id is null then
        -- No ID passed, get one from the sequence
        select seq_auto_debit.nextval into :new.autodebit_id from dual;
    else
        -- ID was set via insert, so update the sequence
        select greatest(nvl(max(autodebit_id),0), :new.autodebit_id) into max_id from auto_debit;
        select seq_auto_debit.nextval into cur_seq from dual;
        while cur_seq < max_id
        loop
            select seq_auto_debit.nextval into cur_seq from dual;
        end loop;
    end if;
end;
/
ALTER TRIGGER  "TRIG_BEF_AUTO_DEBIT" ENABLE;CREATE OR REPLACE TRIGGER  "TRIG_BEF_CREDIT_HIST" 
before insert on credit_history
for each row
declare
    max_id number;
    cur_seq number;
begin
    if :new.credit_id is null then
        -- No ID passed, get one from the sequence
        select seq_credit_hist.nextval into :new.credit_id from dual;
    else
        -- ID was set via insert, so update the sequence
        select greatest(nvl(max(credit_id),0), :new.credit_id) into max_id from credit_history;
        select seq_credit_hist.nextval into cur_seq from dual;
        while cur_seq < max_id
        loop
            select seq_credit_hist.nextval into cur_seq from dual;
        end loop;
    end if;
end;
/
ALTER TRIGGER  "TRIG_BEF_CREDIT_HIST" ENABLE;CREATE OR REPLACE TRIGGER  "TRIG_BEF_DETAILS" 
before insert on details
for each row
declare
    max_id number;
    cur_seq number;
begin
    if :new.bank_ac_no is null then
        -- No ID passed, get one from the sequence
        select seq_bank_acc.nextval into :new.bank_ac_no from dual;
    else
        -- ID was set via insert, so update the sequence
        select greatest(nvl(max(bank_ac_no),0), :new.bank_ac_no) into max_id from details;
        select seq_bank_acc.nextval into cur_seq from dual;
        while cur_seq < max_id
        loop
            select seq_bank_acc.nextval into cur_seq from dual;
        end loop;
    end if;
end;
/
ALTER TRIGGER  "TRIG_BEF_DETAILS" ENABLE;CREATE OR REPLACE TRIGGER  "TRIG_BEF_PENDING_TRANS" 
before insert on pending_trans
for each row
declare
    max_id number;
    cur_seq number;
begin
    if :new.pending_id is null then
        -- No ID passed, get one from the sequence
        select seq_pend_trans.nextval into :new.pending_id from dual;
    else
        -- ID was set via insert, so update the sequence
        select greatest(nvl(max(pending_id),0), :new.pending_id) into max_id from pending_trans;
        select seq_pend_trans.nextval into cur_seq from dual;
        while cur_seq < max_id
        loop
            select seq_pend_trans.nextval into cur_seq from dual;
        end loop;
    end if;
end;
/
ALTER TRIGGER  "TRIG_BEF_PENDING_TRANS" ENABLE;CREATE OR REPLACE TRIGGER  "TRIG_BEF_TRANS_HIST" 
before insert on trans_history
for each row
declare
    max_id number;
    cur_seq number;
begin
    if :new.trans_id is null then
        -- No ID passed, get one from the sequence
        select seq_trans_hist.nextval into :new.trans_id from dual;
    else
        -- ID was set via insert, so update the sequence
        select greatest(nvl(max(trans_id),0), :new.trans_id) into max_id from trans_history;
        select seq_trans_hist.nextval into cur_seq from dual;
        while cur_seq < max_id
        loop
            select seq_trans_hist.nextval into cur_seq from dual;
        end loop;
    end if;
end;
/
ALTER TRIGGER  "TRIG_BEF_TRANS_HIST" ENABLE;
Rem No view found to generate DDL.
Rem No database link found to generate DDL.
Rem No type found to generate DDL.
Rem No materialized view found to generate DDL.
Schema
Object Type
Object Name