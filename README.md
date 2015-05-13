Docker Registry on Heroku [![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)][license]
====

[license]: https://github.com/tcnksm/heroku-docker-registry/blob/master/LICENSE

This is a sample project to run new Go based [Docker Registry](https://github.com/docker/distribution) on Heroku. 

## Deploy to Heroku

To use this respository, you need to install [Heroku docker plugin](https://github.com/heroku/heroku-docker) first, 

```bash
$ heroku plugins:install heroku-docker
```

And deploy, 

```bash
$ heroku create
$ heroku docker:release
```

## Usage

For example Heroku application name is `warm-spire-8712`, to build image,

```bash
$ docker build -t warm-spire-8712.herokuapp.com/tcnksm/test-heroku .
```

To push image,

```bash
$ docker push warm-spire-8712.herokuapp.com/tcnksm/test-heroku
```

To pull image (Before this delete iamge on local), 

```bash
$ docker rmi warm-spire-8712.herokuapp.com/tcnksm/test-heroku 
```

```bash
$ docker pull warm-spire-8712.herokuapp.com/tcnksm/test-heroku
```

## Author

[Taichi Nakashima](https://github.com/tcnksm)
