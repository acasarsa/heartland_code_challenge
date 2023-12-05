# frozen_string_literal: true

module MockData
  INPUT_DATA = <<~DATA
    photo.jpg, Krakow, 2013-09-05 14:08:15
    Mike.png, London, 2015-06-20 15:13:22
    myFriends.png, Krakow, 2013-09-05 14:07:13
    Eiffel.jpg, Florianopolis, 2015-07-23 08:03:02
    pisatower.jpg, Florianopolis, 2015-07-22 23:59:59
    BOB.jpg, London, 2015-08-05 00:02:03
    notredame.png, Florianopolis, 2015-09-01 12:00:00
    me.jpg, Krakow, 2013-09-06 15:40:22
    a.png, Krakow, 2016-02-13 13:33:50
    b.jpg, Krakow, 2016-01-02 15:12:22
    c.jpg, Krakow, 2016-01-02 14:34:30
    d.jpg, Krakow, 2016-01-02 15:15:01
    e.png, Krakow, 2016-01-02 09:49:09
    f.png, Krakow, 2016-01-02 10:55:32
    g.jpg, Krakow, 2016-02-29 22:13:11
  DATA

  EXPECTED_OUTPUT_NEW_FILENAMES = <<~DATA.chomp
    Krakow02.jpg
    London1.png
    Krakow01.png
    Florianopolis2.jpg
    Florianopolis1.jpg
    London2.jpg
    Florianopolis3.png
    Krakow03.jpg
    Krakow09.png
    Krakow07.jpg
    Krakow06.jpg
    Krakow08.jpg
    Krakow04.png
    Krakow05.png
    Krakow10.jpg
  DATA

  EXPECTED_OUTPUT_FROM_PARSE = [
    { filename: 'Krakow02.jpg', city: 'Krakow', timestamp: DateTime.new(2013, 9, 5, 14, 8, 15) },
    { filename: 'London1.png', city: 'London', timestamp: DateTime.new(2015, 6, 20, 15, 13, 22) },
    { filename: 'Krakow01.png', city: 'Krakow', timestamp: DateTime.new(2013, 9, 5, 14, 7, 13) },
    { filename: 'Florianopolis2.jpg', city: 'Florianopolis', timestamp: DateTime.new(2015, 7, 23, 8, 3, 2) },
    { filename: 'Florianopolis1.jpg', city: 'Florianopolis', timestamp: DateTime.new(2015, 7, 22, 23, 59, 59) },
    { filename: 'London2.jpg', city: 'London', timestamp: DateTime.new(2015, 8, 5, 0, 2, 3) },
    { filename: 'Florianopolis3.png', city: 'Florianopolis', timestamp: DateTime.new(2015, 9, 1, 12, 0, 0) },
    { filename: 'Krakow03.jpg', city: 'Krakow', timestamp: DateTime.new(2013, 9, 6, 15, 40, 22) },
    { filename: 'Krakow09.png', city: 'Krakow', timestamp: DateTime.new(2016, 2, 13, 13, 33, 50) },
    { filename: 'Krakow07.jpg', city: 'Krakow', timestamp: DateTime.new(2016, 1, 2, 15, 12, 22) },
    { filename: 'Krakow06.jpg', city: 'Krakow', timestamp: DateTime.new(2016, 1, 2, 14, 34, 30) },
    { filename: 'Krakow08.jpg', city: 'Krakow', timestamp: DateTime.new(2016, 1, 2, 15, 15, 1) },
    { filename: 'Krakow04.png', city: 'Krakow', timestamp: DateTime.new(2016, 1, 2, 9, 49, 9) },
    { filename: 'Krakow05.png', city: 'Krakow', timestamp: DateTime.new(2016, 1, 2, 10, 55, 32) },
    { filename: 'Krakow10.jpg', city: 'Krakow', timestamp: DateTime.new(2016, 2, 29, 22, 13, 11) }
  ].freeze

  INPUT_DATA_100 = <<~DATA
    photo1.jpg, London, 2000-01-01 12:34:56
    photo2.jpg, London, 2000-02-02 13:45:21
    photo3.jpg, London, 2000-03-03 14:56:37
    photo4.jpg, London, 2000-04-04 15:47:42
    photo5.jpg, London, 2000-05-05 16:58:59
    photo6.jpg, London, 2000-06-06 17:09:14
    photo7.jpg, London, 2000-07-07 18:20:27
    photo8.jpg, London, 2000-08-08 19:31:38
    photo9.jpg, London, 2000-09-09 20:42:45
    photo10.jpg, London, 2000-10-10 21:53:53
    photo11.jpg, London, 2000-11-11 22:04:01
    photo12.jpg, London, 2000-12-12 23:15:10
    photo13.jpg, London, 2001-01-01 00:26:19
    photo14.jpg, London, 2001-02-02 01:37:29
    photo15.jpg, London, 2001-03-03 02:48:35
    photo16.jpg, London, 2001-04-04 03:59:42
    photo17.jpg, London, 2001-05-05 04:10:52
    photo18.jpg, London, 2001-06-06 05:21:59
    photo19.jpg, London, 2001-07-07 06:33:07
    photo20.jpg, London, 2001-08-08 07:44:15
    photo21.jpg, London, 2001-09-09 08:55:22
    photo22.jpg, London, 2001-10-10 10:06:30
    photo23.jpg, London, 2001-11-11 11:17:37
    photo24.jpg, London, 2001-12-12 12:28:45
    photo25.jpg, London, 2002-01-01 13:39:52
    photo26.jpg, London, 2002-02-02 14:51:00
    photo27.jpg, London, 2002-03-03 16:02:09
    photo28.jpg, London, 2002-04-04 17:13:16
    photo29.jpg, London, 2002-05-05 18:24:23
    photo30.jpg, London, 2002-06-06 19:35:30
    photo31.jpg, London, 2002-07-07 20:46:38
    photo32.jpg, London, 2002-08-08 21:57:46
    photo33.jpg, London, 2002-09-09 23:08:54
    photo34.jpg, London, 2002-10-10 00:20:02
    photo35.jpg, London, 2002-11-11 01:31:10
    photo36.jpg, London, 2002-12-12 02:42:18
    photo37.jpg, London, 2003-01-01 03:53:26
    photo38.jpg, London, 2003-02-02 05:04:34
    photo39.jpg, London, 2003-03-03 06:15:42
    photo40.jpg, London, 2003-04-04 07:26:50
    photo41.jpg, London, 2003-05-05 08:37:58
    photo42.jpg, London, 2003-06-06 09:49:06
    photo43.jpg, London, 2003-07-07 11:00:14
    photo44.jpg, London, 2003-08-08 12:11:22
    photo45.jpg, London, 2003-09-09 13:22:30
    photo46.jpg, London, 2003-10-10 14:33:38
    photo47.jpg, London, 2003-11-11 15:44:46
    photo48.jpg, London, 2003-12-12 16:55:54
    photo49.jpg, London, 2004-01-01 18:07:02
    photo50.jpg, London, 2004-02-02 19:18:10
    photo51.jpg, London, 2004-03-03 20:29:18
    photo52.jpg, London, 2004-04-04 21:40:26
    photo53.jpg, London, 2004-05-05 22:51:34
    photo54.jpg, London, 2004-06-06 00:02:42
    photo55.jpg, London, 2004-07-07 01:13:50
    photo56.jpg, London, 2004-08-08 02:24:58
    photo57.jpg, London, 2004-09-09 03:36:06
    photo58.jpg, London, 2004-10-10 04:47:14
    photo59.jpg, London, 2004-11-11 05:58:22
    photo60.jpg, London, 2004-12-12 07:09:30
    photo61.jpg, London, 2005-01-01 08:20:38
    photo62.jpg, London, 2005-02-02 09:31:46
    photo63.jpg, London, 2005-03-03 10:42:54
    photo64.jpg, London, 2005-04-04 11:54:02
    photo65.jpg, London, 2005-05-05 13:05:10
    photo66.jpg, London, 2005-06-06 14:16:18
    photo67.jpg, London, 2005-07-07 15:27:26
    photo68.jpg, London, 2005-08-08 16:38:34
    photo69.jpg, London, 2005-09-09 17:49:42
    photo70.jpg, London, 2005-10-10 19:00:50
    photo71.jpg, London, 2005-11-11 20:11:58
    photo72.jpg, London, 2005-12-12 21:23:06
    photo73.jpg, London, 2006-01-01 22:34:14
    photo74.jpg, London, 2006-02-02 23:45:22
    photo75.jpg, London, 2006-03-03 00:56:30
    photo76.jpg, London, 2006-04-04 02:07:38
    photo77.jpg, London, 2006-05-05 03:18:46
    photo78.jpg, London, 2006-06-06 04:29:54
    photo79.jpg, London, 2006-07-07 05:41:02
    photo80.jpg, London, 2006-08-08 06:52:10
    photo81.jpg, London, 2006-09-09 08:03:18
    photo82.jpg, London, 2006-10-10 09:14:26
    photo83.jpg, London, 2006-11-11 10:25:34
    photo84.jpg, London, 2006-12-12 11:36:42
    photo85.jpg, London, 2007-01-01 12:47:50
    photo86.jpg, London, 2007-02-02 13:59:58
    photo87.jpg, London, 2007-03-03 15:11:06
    photo88.jpg, London, 2007-04-04 16:22:14
    photo89.jpg, London, 2007-05-05 17:33:22
    photo90.jpg, London, 2007-06-06 18:44:30
    photo91.jpg, London, 2007-07-07 19:55:38
    photo92.jpg, London, 2007-08-08 21:06:46
    photo93.jpg, London, 2007-09-09 22:17:54
    photo94.jpg, London, 2007-10-10 23:29:02
    photo95.jpg, London, 2007-11-11 00:40:10
    photo96.jpg, London, 2007-12-12 01:51:18
    photo97.jpg, London, 2008-01-01 03:02:26
    photo98.jpg, London, 2008-02-02 04:13:34
    photo99.jpg, London, 2008-03-03 05:24:42
    photo100.jpg, London, 2008-04-04 06:35:50
  DATA

  EXPECTED_OUTPUT_100 = <<~DATA.chomp
    London001.jpg
    London002.jpg
    London003.jpg
    London004.jpg
    London005.jpg
    London006.jpg
    London007.jpg
    London008.jpg
    London009.jpg
    London010.jpg
    London011.jpg
    London012.jpg
    London013.jpg
    London014.jpg
    London015.jpg
    London016.jpg
    London017.jpg
    London018.jpg
    London019.jpg
    London020.jpg
    London021.jpg
    London022.jpg
    London023.jpg
    London024.jpg
    London025.jpg
    London026.jpg
    London027.jpg
    London028.jpg
    London029.jpg
    London030.jpg
    London031.jpg
    London032.jpg
    London033.jpg
    London034.jpg
    London035.jpg
    London036.jpg
    London037.jpg
    London038.jpg
    London039.jpg
    London040.jpg
    London041.jpg
    London042.jpg
    London043.jpg
    London044.jpg
    London045.jpg
    London046.jpg
    London047.jpg
    London048.jpg
    London049.jpg
    London050.jpg
    London051.jpg
    London052.jpg
    London053.jpg
    London054.jpg
    London055.jpg
    London056.jpg
    London057.jpg
    London058.jpg
    London059.jpg
    London060.jpg
    London061.jpg
    London062.jpg
    London063.jpg
    London064.jpg
    London065.jpg
    London066.jpg
    London067.jpg
    London068.jpg
    London069.jpg
    London070.jpg
    London071.jpg
    London072.jpg
    London073.jpg
    London074.jpg
    London075.jpg
    London076.jpg
    London077.jpg
    London078.jpg
    London079.jpg
    London080.jpg
    London081.jpg
    London082.jpg
    London083.jpg
    London084.jpg
    London085.jpg
    London086.jpg
    London087.jpg
    London088.jpg
    London089.jpg
    London090.jpg
    London091.jpg
    London092.jpg
    London093.jpg
    London094.jpg
    London095.jpg
    London096.jpg
    London097.jpg
    London098.jpg
    London099.jpg
    London100.jpg
  DATA
end
