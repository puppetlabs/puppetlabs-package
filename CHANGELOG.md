<!-- markdownlint-disable MD024 -->
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org).

## [v3.1.0](https://github.com/puppetlabs/puppetlabs-package/tree/v3.1.0) - 2024-12-17

[Full Changelog](https://github.com/puppetlabs/puppetlabs-package/compare/v3.0.1...v3.1.0)

### Added

- (CAT-2125) Add Ubuntu 24.04 support [#341](https://github.com/puppetlabs/puppetlabs-package/pull/341) ([shubhamshinde360](https://github.com/shubhamshinde360))
- (CAT-2100) Add Debian 12 support [#340](https://github.com/puppetlabs/puppetlabs-package/pull/340) ([shubhamshinde360](https://github.com/shubhamshinde360))

### Fixed

- (CAT-2158) Upgrade rexml to address CVE-2024-49761 [#342](https://github.com/puppetlabs/puppetlabs-package/pull/342) ([amitkarsale](https://github.com/amitkarsale))

## [v3.0.1](https://github.com/puppetlabs/puppetlabs-package/tree/v3.0.1) - 2024-03-01

[Full Changelog](https://github.com/puppetlabs/puppetlabs-package/compare/v3.0.0...v3.0.1)

### Fixed

- Remove unwanted lines from yum output [#316](https://github.com/puppetlabs/puppetlabs-package/pull/316) ([mlemily](https://github.com/mlemily))

## [v3.0.0](https://github.com/puppetlabs/puppetlabs-package/tree/v3.0.0) - 2023-04-19

[Full Changelog](https://github.com/puppetlabs/puppetlabs-package/compare/v2.4.0...v3.0.0)

### Changed

- (CONT-791) - Add Puppet 8/Drop Puppet 6 [#307](https://github.com/puppetlabs/puppetlabs-package/pull/307) ([jordanbreen28](https://github.com/jordanbreen28))

## [v2.4.0](https://github.com/puppetlabs/puppetlabs-package/tree/v2.4.0) - 2023-04-19

[Full Changelog](https://github.com/puppetlabs/puppetlabs-package/compare/v2.3.0...v2.4.0)

### Added

- Add Compatibility with FreeBSD [#306](https://github.com/puppetlabs/puppetlabs-package/pull/306) ([smortex](https://github.com/smortex))
- Improve package status consistency on Debian [#303](https://github.com/puppetlabs/puppetlabs-package/pull/303) ([smortex](https://github.com/smortex))

### Fixed

- Fix shebangs [#305](https://github.com/puppetlabs/puppetlabs-package/pull/305) ([smortex](https://github.com/smortex))
- Unset user-defined locale variables [#304](https://github.com/puppetlabs/puppetlabs-package/pull/304) ([smortex](https://github.com/smortex))
- pdksync - (CONT-189) Remove support for RedHat6 / OracleLinux6 [#292](https://github.com/puppetlabs/puppetlabs-package/pull/292) ([david22swan](https://github.com/david22swan))
- pdksync - (CONT-130) - Dropping Support for Debian 9 [#289](https://github.com/puppetlabs/puppetlabs-package/pull/289) ([jordanbreen28](https://github.com/jordanbreen28))

## [v2.3.0](https://github.com/puppetlabs/puppetlabs-package/tree/v2.3.0) - 2022-10-03

[Full Changelog](https://github.com/puppetlabs/puppetlabs-package/compare/v2.2.0...v2.3.0)

### Added

- pdksync - (GH-cat-11) Certify Support for Ubuntu 22.04 [#286](https://github.com/puppetlabs/puppetlabs-package/pull/286) ([david22swan](https://github.com/david22swan))
- pdksync - (GH-cat-12) Add Support for Redhat 9 [#285](https://github.com/puppetlabs/puppetlabs-package/pull/285) ([david22swan](https://github.com/david22swan))

### Fixed

- (MAINT) Drop support for windows server 2008 R2. [#287](https://github.com/puppetlabs/puppetlabs-package/pull/287) ([jordanbreen28](https://github.com/jordanbreen28))

## [v2.2.0](https://github.com/puppetlabs/puppetlabs-package/tree/v2.2.0) - 2022-05-30

[Full Changelog](https://github.com/puppetlabs/puppetlabs-package/compare/v2.1.0...v2.2.0)

### Added

- pdksync - (FM-8922) - Add Support for Windows 2022 [#275](https://github.com/puppetlabs/puppetlabs-package/pull/275) ([david22swan](https://github.com/david22swan))
- pdksync - (IAC-1753) - Add Support for AlmaLinux 8 [#270](https://github.com/puppetlabs/puppetlabs-package/pull/270) ([david22swan](https://github.com/david22swan))
- pdksync - (IAC-1751) - Add Support for Rocky 8 [#269](https://github.com/puppetlabs/puppetlabs-package/pull/269) ([david22swan](https://github.com/david22swan))
- Expose package manager options to task [#265](https://github.com/puppetlabs/puppetlabs-package/pull/265) ([MartyEwings](https://github.com/MartyEwings))

### Fixed

- pdksync - (GH-iac-334) Remove Support for Ubuntu 14.04/16.04 [#277](https://github.com/puppetlabs/puppetlabs-package/pull/277) ([david22swan](https://github.com/david22swan))
- pdksync - (IAC-1787) Remove Support for CentOS 6 [#273](https://github.com/puppetlabs/puppetlabs-package/pull/273) ([david22swan](https://github.com/david22swan))
- pdksync - (IAC-1598) - Remove Support for Debian 8 [#268](https://github.com/puppetlabs/puppetlabs-package/pull/268) ([david22swan](https://github.com/david22swan))

## [v2.1.0](https://github.com/puppetlabs/puppetlabs-package/tree/v2.1.0) - 2021-08-16

[Full Changelog](https://github.com/puppetlabs/puppetlabs-package/compare/v2.0.0...v2.1.0)

### Added

- pdksync - (IAC-1720) - Add Support for Ubuntu 20.04 [#263](https://github.com/puppetlabs/puppetlabs-package/pull/263) ([david22swan](https://github.com/david22swan))
- pdksync - (IAC-1709) - Add Support for Debian 11 [#261](https://github.com/puppetlabs/puppetlabs-package/pull/261) ([david22swan](https://github.com/david22swan))
- pdksync - (IAC-1719) - Add Support for Debian 10 [#260](https://github.com/puppetlabs/puppetlabs-package/pull/260) ([david22swan](https://github.com/david22swan))

## [v2.0.0](https://github.com/puppetlabs/puppetlabs-package/tree/v2.0.0) - 2021-03-02

[Full Changelog](https://github.com/puppetlabs/puppetlabs-package/compare/v1.4.0...v2.0.0)

### Changed

- pdksync - Remove RHEL 5 family support [#240](https://github.com/puppetlabs/puppetlabs-package/pull/240) ([sanfrancrisko](https://github.com/sanfrancrisko))
- pdksync - Remove Puppet 5 from testing and bump minimal version to 6.0.0 [#235](https://github.com/puppetlabs/puppetlabs-package/pull/235) ([carabasdaniel](https://github.com/carabasdaniel))

### Fixed

- Fix package task for yum when passing version [#237](https://github.com/puppetlabs/puppetlabs-package/pull/237) ([cliveweir](https://github.com/cliveweir))

## [v1.4.0](https://github.com/puppetlabs/puppetlabs-package/tree/v1.4.0) - 2020-12-09

[Full Changelog](https://github.com/puppetlabs/puppetlabs-package/compare/v1.3.0...v1.4.0)

### Added

- pdksync - (feat) - Add support for Puppet 7 [#224](https://github.com/puppetlabs/puppetlabs-package/pull/224) ([daianamezdrea](https://github.com/daianamezdrea))
- (MODULES-10842) - Allow version to be set when installing via init task [#217](https://github.com/puppetlabs/puppetlabs-package/pull/217) ([david22swan](https://github.com/david22swan))

### Fixed

- (MODULES-10844) Fix missing version info in task output [#216](https://github.com/puppetlabs/puppetlabs-package/pull/216) ([pgrant87](https://github.com/pgrant87))

## [v1.3.0](https://github.com/puppetlabs/puppetlabs-package/tree/v1.3.0) - 2020-10-01

[Full Changelog](https://github.com/puppetlabs/puppetlabs-package/compare/v1.2.0...v1.3.0)

### Added

- pdksync - (IAC-973) - Update travis/appveyor to run on new default branch `main` [#208](https://github.com/puppetlabs/puppetlabs-package/pull/208) ([david22swan](https://github.com/david22swan))

### Fixed

- pdksync - (feat) - Removal of inappropriate terminology [#213](https://github.com/puppetlabs/puppetlabs-package/pull/213) ([pmcmaw](https://github.com/pmcmaw))

## [v1.2.0](https://github.com/puppetlabs/puppetlabs-package/tree/v1.2.0) - 2020-06-26

[Full Changelog](https://github.com/puppetlabs/puppetlabs-package/compare/v1.1.0...v1.2.0)

### Added

- (IAC-908) Add support for package status in Windows [#200](https://github.com/puppetlabs/puppetlabs-package/pull/200) ([fhrbek](https://github.com/fhrbek))

## [v1.1.0](https://github.com/puppetlabs/puppetlabs-package/tree/v1.1.0) - 2019-12-11

[Full Changelog](https://github.com/puppetlabs/puppetlabs-package/compare/v1.0.0...v1.1.0)

### Added

- pdksync - "MODULES-10242 Add ubuntu14 support back to the modules" [#167](https://github.com/puppetlabs/puppetlabs-package/pull/167) ([sheenaajay](https://github.com/sheenaajay))

## [v1.0.0](https://github.com/puppetlabs/puppetlabs-package/tree/v1.0.0) - 2019-12-02

[Full Changelog](https://github.com/puppetlabs/puppetlabs-package/compare/v0.7.0...v1.0.0)

### Changed

- pdksync - FM-8499 remove ubuntu 14 support [#164](https://github.com/puppetlabs/puppetlabs-package/pull/164) ([lionce](https://github.com/lionce))

### Added

- (FM-8692) - Addition of Support for CentOS 8 [#161](https://github.com/puppetlabs/puppetlabs-package/pull/161) ([david22swan](https://github.com/david22swan))

## [v0.7.0](https://github.com/puppetlabs/puppetlabs-package/tree/v0.7.0) - 2019-10-28

[Full Changelog](https://github.com/puppetlabs/puppetlabs-package/compare/v0.6.0...v0.7.0)

### Added

- (BOLT-1525) Zypper implementation [#143](https://github.com/puppetlabs/puppetlabs-package/pull/143) ([m0dular](https://github.com/m0dular))
- (FM-8225) Convert to litmus testing [#134](https://github.com/puppetlabs/puppetlabs-package/pull/134) ([sheenaajay](https://github.com/sheenaajay))

## [v0.6.0](https://github.com/puppetlabs/puppetlabs-package/tree/v0.6.0) - 2019-06-13

[Full Changelog](https://github.com/puppetlabs/puppetlabs-package/compare/v0.5.0...v0.6.0)

### Changed

- pdksync - (MODULES-8444) - Raise lower Puppet bound [#123](https://github.com/puppetlabs/puppetlabs-package/pull/123) ([david22swan](https://github.com/david22swan))

### Added

- (FM-8156) Add Windows Server 2019 support [#129](https://github.com/puppetlabs/puppetlabs-package/pull/129) ([eimlav](https://github.com/eimlav))
- (FM-8044) Add Redhat8 support [#128](https://github.com/puppetlabs/puppetlabs-package/pull/128) ([sheenaajay](https://github.com/sheenaajay))
- (Bolt-1104) - Add linux package task uninstall [#126](https://github.com/puppetlabs/puppetlabs-package/pull/126) ([m0dular](https://github.com/m0dular))

### Fixed

- FM-7946 stringify package [#127](https://github.com/puppetlabs/puppetlabs-package/pull/127) ([lionce](https://github.com/lionce))

## [v0.5.0](https://github.com/puppetlabs/puppetlabs-package/tree/v0.5.0) - 2019-04-10

[Full Changelog](https://github.com/puppetlabs/puppetlabs-package/compare/0.4.1...v0.5.0)

### Added

- (SEN-795) Move extension metadata to init.json [#119](https://github.com/puppetlabs/puppetlabs-package/pull/119) ([conormurray95](https://github.com/conormurray95))
- (SEN-795) Add discovery extension metadata [#118](https://github.com/puppetlabs/puppetlabs-package/pull/118) ([conormurray95](https://github.com/conormurray95))
- (BOLT-1104) Unify task implementation output [#117](https://github.com/puppetlabs/puppetlabs-package/pull/117) ([donoghuc](https://github.com/donoghuc))

### Fixed

- (MODULES-8717) Fix for boltspec run dependancy issue [#113](https://github.com/puppetlabs/puppetlabs-package/pull/113) ([HelenCampbell](https://github.com/HelenCampbell))

## [0.4.1](https://github.com/puppetlabs/puppetlabs-package/tree/0.4.1) - 2019-01-09

[Full Changelog](https://github.com/puppetlabs/puppetlabs-package/compare/0.4.0...0.4.1)

### Fixed

- (MODULES-8425) Move to GEM_BOLT pattern [#100](https://github.com/puppetlabs/puppetlabs-package/pull/100) ([donoghuc](https://github.com/donoghuc))

## [0.4.0](https://github.com/puppetlabs/puppetlabs-package/tree/0.4.0) - 2019-01-08

[Full Changelog](https://github.com/puppetlabs/puppetlabs-package/compare/0.3.0...0.4.0)

### Added

- (MODULES-8390) Enable implementations on the init task and hide others [#96](https://github.com/puppetlabs/puppetlabs-package/pull/96) ([MikaelSmith](https://github.com/MikaelSmith))

### Fixed

- pdksync - (FM-7655) Fix rubygems-update for ruby < 2.3 [#97](https://github.com/puppetlabs/puppetlabs-package/pull/97) ([tphoney](https://github.com/tphoney))
- (MODULES-8045) Fix apt-get upgrading everything when no version passed and apt is package manager. [#92](https://github.com/puppetlabs/puppetlabs-package/pull/92) ([eoinmcq](https://github.com/eoinmcq))

## [0.3.0](https://github.com/puppetlabs/puppetlabs-package/tree/0.3.0) - 2018-09-28

[Full Changelog](https://github.com/puppetlabs/puppetlabs-package/compare/0.2.0...0.3.0)

### Added

- pdksync - (FM-7392) - Puppet 6 Testing Changes [#88](https://github.com/puppetlabs/puppetlabs-package/pull/88) ([pmcmaw](https://github.com/pmcmaw))
- (DI-3260) Adding agentless windows task (for choco) [#81](https://github.com/puppetlabs/puppetlabs-package/pull/81) ([HairyMike](https://github.com/HairyMike))
- (DI-2373) Adding agentless linux task [#77](https://github.com/puppetlabs/puppetlabs-package/pull/77) ([tphoney](https://github.com/tphoney))
- (FM-7263) - Addition of support for ubuntu 18.04 [#70](https://github.com/puppetlabs/puppetlabs-package/pull/70) ([david22swan](https://github.com/david22swan))
- [FM-7058] Addition of support for Debian 9 to package [#69](https://github.com/puppetlabs/puppetlabs-package/pull/69) ([david22swan](https://github.com/david22swan))

## [0.2.0](https://github.com/puppetlabs/puppetlabs-package/tree/0.2.0) - 2018-03-05

[Full Changelog](https://github.com/puppetlabs/puppetlabs-package/compare/0.1.5...0.2.0)

## [0.1.5](https://github.com/puppetlabs/puppetlabs-package/tree/0.1.5) - 2017-10-11

[Full Changelog](https://github.com/puppetlabs/puppetlabs-package/compare/0.1.4...0.1.5)

## [0.1.4](https://github.com/puppetlabs/puppetlabs-package/tree/0.1.4) - 2017-10-10

[Full Changelog](https://github.com/puppetlabs/puppetlabs-package/compare/0.1.3...0.1.4)

## [0.1.3](https://github.com/puppetlabs/puppetlabs-package/tree/0.1.3) - 2017-10-04

[Full Changelog](https://github.com/puppetlabs/puppetlabs-package/compare/0.1.2...0.1.3)

## [0.1.2](https://github.com/puppetlabs/puppetlabs-package/tree/0.1.2) - 2017-09-21

[Full Changelog](https://github.com/puppetlabs/puppetlabs-package/compare/0.1.1...0.1.2)

## [0.1.1](https://github.com/puppetlabs/puppetlabs-package/tree/0.1.1) - 2017-09-20

[Full Changelog](https://github.com/puppetlabs/puppetlabs-package/compare/0.1.0...0.1.1)

### Fixed

- (maint) Fix windows providers without latest or pluginsync'd [#33](https://github.com/puppetlabs/puppetlabs-package/pull/33) ([hunner](https://github.com/hunner))

## [0.1.0](https://github.com/puppetlabs/puppetlabs-package/tree/0.1.0) - 2017-09-11

[Full Changelog](https://github.com/puppetlabs/puppetlabs-package/compare/d6adc1de46d86ce3bc0c15c31ad3edd8e760e9a3...0.1.0)
