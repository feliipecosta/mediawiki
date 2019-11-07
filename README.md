# MediaWiki

[![Build Status](https://travis-ci.org/feliipecosta/mediawiki.svg?branch=master)](https://travis-ci.org/feliipecosta/mediawiki)

Deploy AWS instance with terraform and configure Mediawiki with ansible.

### Provisioning Environment

1 - Change "credentials" files with AWS user credentials and change the "aws_user_name" parameter at variables.tf file.

2 - Execute "deploy.sh"

```sh
$ ./deploy.sh
```

3 - Access public IP or public DNS in your browser.  


### Dependencies

Installed dependencies in environment.

| Packages | Docs |
| ------ | ------ |
| apache2 | http://httpd.apache.org/docs/ |
| mariadb-server | https://mariadb.com/kb/pt/documentation/ |
| php | https://www.php.net/docs.php |
| python3-pymysql | https://pymysql.readthedocs.io/en/latest/ |
| mediawiki | https://www.mediawiki.org/wiki/Documentation |



