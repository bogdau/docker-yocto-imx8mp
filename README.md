# Documentation 

To initialize environment use this command:
```sh
source imx-setup-release.sh
```

To build image: 

```sh
bitbake core-image-minimal
```

You can find it there: 

``` sh
/home/yocto/build/tmp/deploy/images/<name of the board>/core-image-minimal-<name of the board>.wic.zst
```

<br>
Official repo

https://github.com/SolidRun/meta-solidrun-arm-imx8/tree/kirkstone-imx8m

<br>

Full name of the board in the u-boot configuration
> imx8mp_solidrun_defconfig

<br>