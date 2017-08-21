'use strict';

var gulp = require('gulp'),
  uglify = require('gulp-uglify'),
  rename = require('gulp-rename'),
  sass = require('gulp-sass'),
  maps = require('gulp-sourcemaps'),
  del = require('del'),
  useref = require('gulp-useref'),
  iff = require('gulp-if'),
  csso = require('gulp-csso'),
  browserSync = require('browser-sync').create(),
  postcss = require('gulp-postcss'),
  autoprefixer = require('autoprefixer'),
  plumber = require('gulp-plumber'),
  uncss = require('gulp-uncss'),
  htmlmin = require('gulp-htmlmin'),
  imagemin = require('gulp-imagemin'),
  imageminMozjpeg = require('imagemin-mozjpeg'),
  imageminJpegrecompress = require('imagemin-jpeg-recompress'),
  imageminPngquant = require('imagemin-pngquant'),
  babel = require('gulp-babel'),
  ghPages = require('gulp-gh-pages');

var options = {
  src: 'src',
  dist: 'dist',
  test: 'optimization-testing/public'
};

gulp.task('deploy', function() {
  return gulp.src('./dist/**/*').pipe(ghPages());
});

gulp.task('compileSass', function() {
  return gulp
    .src(options.src + '/scss/**/*.scss')
    .pipe(plumber())
    .pipe(maps.init())
    .pipe(sass())
    .pipe(postcss([autoprefixer()]))
    .pipe(maps.write('./'))
    .pipe(gulp.dest(options.src + '/css'))
    .pipe(browserSync.stream());
});

gulp.task('serve', ['compileSass'], function() {
  browserSync.init({
    server: './src'
  });

  gulp.watch(options.src + '/scss/**/*.scss', ['compileSass']);
  gulp.watch(options.src + '**/*.html').on('change', browserSync.reload);
  gulp.watch(options.src + '/js/**/*.js').on('change', browserSync.reload);
});

gulp.task('clean', function() {
  return del(options.dist, 'css/app*.css*', 'js/app*.js*');
});

gulp.task('cleanMaster', function() {
  return del(['css/', 'js/', 'img/', 'audio/', 'video/', 'index.html']);
});

gulp.task('cleanTest', function() {
  return del([options.test + '/**']);
});

gulp.task('cleanAll', function() {
  gulp.start('clean');
  gulp.start('cleanMaster');
});

gulp.task('html', function() {
  gulp
    .src(options.src + '/**/*.html')
    .pipe(useref())
    .pipe(
      iff(
        '*.html',
        htmlmin({
          collapseWhitespace: true
        })
      )
    )
    .pipe(iff('*.js', babel()))
    .pipe(iff('*.js', uglify()))
    .pipe(iff('*.css', csso()))
    .pipe(gulp.dest(options.dist));
});

gulp.task('optimizeImage', function() {
  gulp
    .src(options.src + '/assets_original/**/*')
    .pipe(
      imagemin([
        imagemin.gifsicle({
          interlaced: true
        }),
        imagemin.jpegtran({
          progressive: true
        }),
        imagemin.optipng({
          optimizationLevel: 5
        }),
        imagemin.svgo({
          plugins: [
            {
              removeViewBox: true,
              cleanupAttrs: true
            }
          ]
        }),
        imageminJpegrecompress({
          min: 25,
          max: 25,
          quality: 'low'
        }),
        imageminPngquant({
          quality: 25
        })
      ])
    )
    .pipe(gulp.dest(options.src + '/img/'));
});

gulp.task('copyImage', function() {
  return gulp
    .src(options.src + '/img/**')
    .pipe(gulp.dest(options.dist + '/img'));
});

gulp.task('copyFonts', function() {
  return gulp
    .src(options.src + '/fonts/**')
    .pipe(gulp.dest(options.dist + '/fonts'));
});

gulp.task('copyAudio', function() {
  return gulp
    .src(options.src + '/audio/**')
    .pipe(gulp.dest(options.dist + '/audio'));
});

gulp.task('copyVideo', function() {
  return gulp
    .src(options.src + '/video/**')
    .pipe(gulp.dest(options.dist + '/video'));
});

gulp.task('copyTest', function() {
  return gulp.src(options.dist + '/**').pipe(gulp.dest(options.test));
});

gulp.task('prepareTest', ['cleanTest'], function() {
  gulp.start('copyTest');
});

gulp.task('build', ['html'], function() {
  gulp.start('copyImage');
  gulp.start('copyFonts');
  gulp.start('copyAudio');
  gulp.start('copyVideo');
  gulp.start('prepareTest');
});

gulp.task('deployMaster', function() {
  return gulp.src(options.dist + '/**').pipe(gulp.dest(''));
});

gulp.task('default', ['clean'], function() {
  gulp.start('build');
});
