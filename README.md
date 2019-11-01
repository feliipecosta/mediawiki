# MediaWiki

Sobe uma instância na AWS e configura o mediawiki e o exporter apache e node do prometheus(54.162.245.143)

### Provisionamento do Ambiente

1 - Altere o arquivo "credentials" com as credênciais do usuário criado no IAM da AWS
2 - Execute o arquivo "deploy.sh"

```sh
$ ./deploy.sh
```

3 - Acesse o IP Público ou DNS Público pelo navegador.  


### Dependências

Dependências instaladas no ambiente.

| Package | Documentação |
| ------ | ------ |
| apache2 | http://httpd.apache.org/docs/ |
| mariadb-server | https://mariadb.com/kb/pt/documentation/ |
| php | https://www.php.net/docs.php |
| python3-pymysql | https://pymysql.readthedocs.io/en/latest/ |
| golang | https://golang.org/doc/ |
| mediawiki | https://www.mediawiki.org/wiki/Documentation |



