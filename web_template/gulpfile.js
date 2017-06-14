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
    ghPages = require('gulp-gh-pages');

var options = {
    src: 'src', 
    dist: 'dist'
};

gulp.task('deploy', function(){ 
    return gulp.src('./dist/**/*')
        .pipe(ghPages());
});

gulp.task('compileSass', function(){
    return gulp.src(options.src + '/scss/app.scss')
        .pipe(plumber())
        .pipe(maps.init())
        .pipe(sass())
        .pipe(postcss([ autoprefixer() ]))
        .pipe(maps.write('./'))
        .pipe(gulp.dest(options.src+'/css'))
        .pipe(browserSync.stream());
});

gulp.task('serve', ['compileSass'], function(){
    browserSync.init({
        server: "./src"
    });
    
    gulp.watch(options.src + '/scss/**/*.scss', ['compileSass']);
    gulp.watch(options.src + '**/*.html').on('change', browserSync.reload);
    gulp.watch(options.src + '/js/**/*.js').on('change', browserSync.reload);
});

gulp.task('clean', function(){
    return del(options.dist, 'css/app*.css*', 'js/app*.js*');
});

gulp.task('html', function(){
    gulp.src(options.src + '/index.html')
        .pipe(useref())
        //.pipe(iff('*.js', uglify()))
        .pipe(iff('*.css', csso()))
        .pipe(gulp.dest(options.dist));
});

gulp.task('copyImage', function(){
    return gulp.src(options.src + '/img/**')
        .pipe(gulp.dest(options.dist + '/img'));
});

gulp.task('copyFonts', function(){
    return gulp.src(options.src + '/fonts/**')
        .pipe(gulp.dest(options.dist + '/fonts'));
});

gulp.task('copyAudio', function(){
    return gulp.src(options.src + '/audio/**')
        .pipe(gulp.dest(options.dist + '/audio'));
});

gulp.task('copyVideo', function(){
    return gulp.src(options.src + '/video')
        .pipe(gulp.dest(options.dist + '/video'));
});

gulp.task('build', ['html'], function(){
    gulp.start('copyImage');
    gulp.start('copyFonts');
    gulp.start('copyAudio');
    gulp.start('copyVideo');
});

gulp.task('default', ['clean'], function(){
    gulp.start('build');
});