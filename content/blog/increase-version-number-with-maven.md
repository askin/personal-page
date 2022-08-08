---
title: Increase Version Number With Maven
date: 2022-08-08T20:40:25+03:00
Author: Aşkın Özgür
Tags: ["Maven"]
Slug: increase-version-number-with-maven
draft: false
---

If you have a `maven` project and want to change version number automatically, there is `buil-helper` **maven plugin** to do this. Let's assume that we have a `pom.xml` like below. 

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>com.mycompany.app</groupId>
  <artifactId>my-app</artifactId>
  <version>1.0.0</version>

  <name>my-app</name>
</project>
```

We can update version number from `1.0.0` to `1.0.5` with the command below.
```sh
mvn versions:set -DnewVersion=1.0.5 versions:commit
```

Or we can use this command **increase** version number automatically. 

```sh
mvn build-helper:parse-version versions:set \
    -DnewVersion=\${parsedVersion.majorVersion}.\${parsedVersion.minorVersion}.\${parsedVersion.nextIncrementalVersion} \
    versions:commit
```

Now version number is `1.0.6`

To increase minor version number

```sh
mvn build-helper:parse-version \
    versions:set \
    -DnewVersion=\${parsedVersion.majorVersion}.\${parsedVersion.nextMinorVersion}.\${parsedVersion.buildNumber} \
    versions:commit
```

To increase major version number

```sh
mvn build-helper:parse-version versions:set \
    -DnewVersion=\${parsedVersion.nextMajorVersion}.0.0 \
    versions:commit
```

You can visit [Build Helper Maven Plugin](https://www.mojohaus.org/build-helper-maven-plugin/parse-version-mojo.html "Build Helper Maven Plugin")'s page for more detailed information.

<!--more-->
