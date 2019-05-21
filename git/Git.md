# Git

한마디로? 분산형 버전 관리 시스템의 한 종류 (DVCS)

> 소스코드의 이력이 기록된다.



## 기본 명령어

1. git 저장소(`repository`) 초기화

   ```bash
   $ git init
   Initialized empty Git repository in C:/Users/user/Desktop/TIL/.git/
   user@DESKTOP-VPQ19IS MINGW64 ~/Desktop/TIL (master)
   
   # 결과까지 복사해놓아야 다음에 확인하기 좋다
   
   ```

   `$`표시는 cmd에서 입력 하라는 의미

   * 원하는 폴더를 저장소로 만들게 되면, git bash 에서는 (master)라고 표기된다. 
   * 숨겨진 폴더 .git/ 가 생성된다. 

2. 커밋 할 목록에 담기

   ```bash
   $ git add .
   $ git status
   On branch master
   
   No commits yet
   
   Changes to be committed:
     (use "git rm --cached <file>..." to unstage)
   
           new file:   FirstContact.md
   
   
   ```

   * 현재 작업 공간의 변경사항을 커밋 할 목록에 추가한다.
   * `.` 기호는 리눅스에서 현재 디렉토리를 표기하는 방법으로, 지금 내 폴더에 있는 파일의 변경사항을 전부 추가한다는 뜻이다.
   * 만일 git.md 파일만을 추가하려면, git add git.md 로 추가할 수 있다.
   * 만일 myfolder 폴더를 추가하려면, git add myfolder/ 로 폴더 내의 포든 파일을 추가할 수 있다.
   
3.  커밋 하기

   ```bash
   $ git commit -m '______'
   *** Please tell me who you are.
   
   Run
   
     git config --global user.email "you@example.com"
     git config --global user.name "Your Name"
   
   to set your account's default identity.
   Omit --global to set the identity only in this repository.
   
   fatal: unable to auto-detect email address (got 'user@DESKTOP-VPQ19IS.(none)')
   
   ```

   * 커밋을 할 때에는 해당하는 버전의 이력을 의미하는 메세지를 반드시 적어준다.
   * 메세지는 지금 버전을 쉽게 이해 할 수 있도록 작성한다.
   * 커밋은 현재 코드의 상태를 스냅샷 찍는 것이다.

4. 유저 등록하기

   ```
   $ git config --global user.email "ghnruf@naver.com"
   $ git config --global user.name "HanGyeolN"
   ```

5. 로그 확인하기

   ```bash
   $ git log
   commit 9c9bcf497db4a6f537dca65914580060dad68abb (HEAD -> master)
   Author: HanGyeolN <ghnruf@naver.com>
   Date:   Tue May 21 17:12:34 2019 +0900
   
       190521|마크다운연습
   ```

6. git 상태 확인하기

   ```
   $ git status
   On branch master
   nothing to commit, working tree clean
   ```

   * CLI에서는 현재 상태를 알기 위해 반드시 명령어를 통해 확인해야한다.
   * 커밋 할 목록에 담겨 있는지, untracked 인지, 커밋 할 내역이 없는지 등 다앙한 정보를 알려준다.

7. 












