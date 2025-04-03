<p align="center">
  <a href="https://certbot.eff.org/" target="blank"><img src="https://avatars.githubusercontent.com/u/17889013?s=200&v=4" width="120" alt="Certbot Logo" /></a>
</p>

## 설명

certbot-nginx-server는 Let's Encrypt의 인증서를 certbot을 통한 자동 발급 기능을 제공하는 웹 서버입니다. 이 서버는 `certbot`을 통해 인증서를 발급하고 자동으로 갱신합니다. 도커 컴포즈로 시작하기 전에 인증서를 미리 발급받아야 합니다. 그것은 `init copy.sh`를 참고해서 발급해주세요

## 프로젝트 중요 파일

`init_cert.sh copy` : 초기에 인증서 발급을 위한 예시 스크립트입니다.

`.env copy` : 도커 컴포즈의 구성과 nginx template의 구성을 하는 환경변수입니다.

`default.conf.template` :`default.conf.template`을 기반으로 `conf` 디렉토리에 `default.conf`가 생성됩니다.

`certbot` : certbot의 설정과 인증서가 저장되는 디렉토리입니다.

`docker-compose.yml` : 서버를 자동으로 구축하기 위한 docker-compose입니다.

## 프로젝트 셋업

[1. nginx conf 설정](#nginx-conf-설정)

[2. 초기 인증서 발급 방법](#초기-인증서-발급-방법)

[3. 구성 완료 및 서버 시작](#구성-완료-및-서버-시작)

### nginx conf 설정

`default.conf.template`를 참고하여 nginx 구성을 확인합니다

`.env copy`로 `.env`를 작성합니다.

`.env`에 NGINX_SERVER_NAME 서버 도메인을 넣어주세요.

본 프로젝트는 도메인 소유권을 증명하는 [ACME CHALLENGE](https://letsencrypt.org/docs/challenge-types/) HTTP-01 인증 방식을 사용합니다.

간단한 동작 원리는 `http://&{NGINX_SERVER_NAME}/.well-known/acme-challenge/{token}`에 내가 이 도메인을 소유하고 있다고 증명할수 있는 어떤 파일을 응답하는 식으로 도메인 소유권을 증명합니다. 도메인 소유권이 증명되야 인증서가 발급됩니다.

도커 컴포즈로 실행되면 `.env`와 `default.conf.template`를 통해 컨테이너 내부와 연결된 `conf` 디렉토리에 `default.conf`가 생성됩니다.

### 초기 인증서 발급 방법

`init_cert copy.sh`을 참고하여 `init_cert.sh`를 작성 후 해당 쉘을 실행합니다.

쉘이 실행되고 몇 가지 certbot의 초기 인증서 발급을 위한 실행 과정(라이센스 동의합니까 yes, 이메일 광고 수신 동의 합니까 등)을 거치면 `.well-known/acme-challenge` 관한 설정 안내가 나옵니다. **이때 다음 단계로 절대 넘어가지 마세요.**

프로젝트 디렉토리 내에서 certbot 디렉토리가 생성되고, `certbot/.well-known/acme-challenge/{certbot에서 안내한 파일 이름}`를 생성하고, 파일 안에 `certbot에서 안내한 내용`을 넣습니다.

위 과정이 끝나고 난 후, `http://${DOMAIN_NAME}.well-known/acme-challenge/{certbot에서 안내한 파일 이름}`을 접속했을때 데이터가 제대로 불러와지는지 확인합니다.

만일 여러개의 도메인을 등록한다면, 위 과정을 여러번 반복해야 합니다.

도메인에 접속했을 때 [ACME CHALLENGE](https://letsencrypt.org/docs/challenge-types/) HTTP-01 인증이 된다면 작동한다면 다음 단계로 넘어가 Let's Encrypt 인증서를 발급받습니다. 발급된 인증서는 `certbot/letsencrypt`에 저장됩니다.

### 인증서 자동 갱신 시작

시작할때는 아래와 같이 시작하고

```bash
docker compose up -d
```

아래와 같이 종료하면 됩니다.

```bash
docker compose down
```

### 참고

이미지 관련 에러가 뜨면, 아래와 같이 프로젝트 도커 이미지를 빌드를 해주세요

```bash
docker compose build
```

종료 및 컨테이너 이미지를 깔끔하게 제거합니다.

```bash
docker compose down --rmi all
```
