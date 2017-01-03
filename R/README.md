# The R Docker files

These are R Docker files that I use for testing my packages in new environments. They are built upon the [rocker-org](https://github.com/rocker-org) containers and are a practical approach to satisfying the requirements for [CRAN submissions](https://cran.r-project.org/submit.html).

For running the container all you need to do is do the following (when in the package directory):

```
docker run --rm -it --volume=$PWD:/root/pkg \
  gforge/r-dev
```

Once you are in the container you just write the standard check although note that you must use **RD** and not R as the development branch is in RD:

```bash
./check_pkg.sh
```

in order to get check the package against the latest R dev. version.
