// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SongsTable extends Songs with TableInfo<$SongsTable, Song> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SongsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _artistMeta = const VerificationMeta('artist');
  @override
  late final GeneratedColumn<String> artist = GeneratedColumn<String>(
      'artist', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _albumMeta = const VerificationMeta('album');
  @override
  late final GeneratedColumn<String> album = GeneratedColumn<String>(
      'album', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _durationMeta =
      const VerificationMeta('duration');
  @override
  late final GeneratedColumn<String> duration = GeneratedColumn<String>(
      'duration', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _durationMsMeta =
      const VerificationMeta('durationMs');
  @override
  late final GeneratedColumn<int> durationMs = GeneratedColumn<int>(
      'duration_ms', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bitrateMeta =
      const VerificationMeta('bitrate');
  @override
  late final GeneratedColumn<int> bitrate = GeneratedColumn<int>(
      'bitrate', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _trackNumberMeta =
      const VerificationMeta('trackNumber');
  @override
  late final GeneratedColumn<int> trackNumber = GeneratedColumn<int>(
      'track_number', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
      'year', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _genreMeta = const VerificationMeta('genre');
  @override
  late final GeneratedColumn<String> genre = GeneratedColumn<String>(
      'genre', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _folderMeta = const VerificationMeta('folder');
  @override
  late final GeneratedColumn<String> folder = GeneratedColumn<String>(
      'folder', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _artworkUrlMeta =
      const VerificationMeta('artworkUrl');
  @override
  late final GeneratedColumn<String> artworkUrl = GeneratedColumn<String>(
      'artwork_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isLocalMeta =
      const VerificationMeta('isLocal');
  @override
  late final GeneratedColumn<bool> isLocal = GeneratedColumn<bool>(
      'is_local', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_local" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
      'is_favorite', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_favorite" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        artist,
        album,
        duration,
        durationMs,
        path,
        bitrate,
        trackNumber,
        year,
        genre,
        folder,
        artworkUrl,
        isLocal,
        isFavorite
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'songs';
  @override
  VerificationContext validateIntegrity(Insertable<Song> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('artist')) {
      context.handle(_artistMeta,
          artist.isAcceptableOrUnknown(data['artist']!, _artistMeta));
    } else if (isInserting) {
      context.missing(_artistMeta);
    }
    if (data.containsKey('album')) {
      context.handle(
          _albumMeta, album.isAcceptableOrUnknown(data['album']!, _albumMeta));
    } else if (isInserting) {
      context.missing(_albumMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
          _durationMsMeta,
          durationMs.isAcceptableOrUnknown(
              data['duration_ms']!, _durationMsMeta));
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('bitrate')) {
      context.handle(_bitrateMeta,
          bitrate.isAcceptableOrUnknown(data['bitrate']!, _bitrateMeta));
    }
    if (data.containsKey('track_number')) {
      context.handle(
          _trackNumberMeta,
          trackNumber.isAcceptableOrUnknown(
              data['track_number']!, _trackNumberMeta));
    }
    if (data.containsKey('year')) {
      context.handle(
          _yearMeta, year.isAcceptableOrUnknown(data['year']!, _yearMeta));
    }
    if (data.containsKey('genre')) {
      context.handle(
          _genreMeta, genre.isAcceptableOrUnknown(data['genre']!, _genreMeta));
    }
    if (data.containsKey('folder')) {
      context.handle(_folderMeta,
          folder.isAcceptableOrUnknown(data['folder']!, _folderMeta));
    } else if (isInserting) {
      context.missing(_folderMeta);
    }
    if (data.containsKey('artwork_url')) {
      context.handle(
          _artworkUrlMeta,
          artworkUrl.isAcceptableOrUnknown(
              data['artwork_url']!, _artworkUrlMeta));
    }
    if (data.containsKey('is_local')) {
      context.handle(_isLocalMeta,
          isLocal.isAcceptableOrUnknown(data['is_local']!, _isLocalMeta));
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Song map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Song(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      artist: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}artist'])!,
      album: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}album'])!,
      duration: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}duration'])!,
      durationMs: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_ms']),
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      bitrate: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bitrate']),
      trackNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}track_number']),
      year: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}year']),
      genre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}genre']),
      folder: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}folder'])!,
      artworkUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}artwork_url']),
      isLocal: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_local'])!,
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
    );
  }

  @override
  $SongsTable createAlias(String alias) {
    return $SongsTable(attachedDatabase, alias);
  }
}

class Song extends DataClass implements Insertable<Song> {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String duration;
  final int? durationMs;
  final String path;
  final int? bitrate;
  final int? trackNumber;
  final int? year;
  final String? genre;
  final String folder;
  final String? artworkUrl;
  final bool isLocal;
  final bool isFavorite;
  const Song(
      {required this.id,
      required this.title,
      required this.artist,
      required this.album,
      required this.duration,
      this.durationMs,
      required this.path,
      this.bitrate,
      this.trackNumber,
      this.year,
      this.genre,
      required this.folder,
      this.artworkUrl,
      required this.isLocal,
      required this.isFavorite});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['artist'] = Variable<String>(artist);
    map['album'] = Variable<String>(album);
    map['duration'] = Variable<String>(duration);
    if (!nullToAbsent || durationMs != null) {
      map['duration_ms'] = Variable<int>(durationMs);
    }
    map['path'] = Variable<String>(path);
    if (!nullToAbsent || bitrate != null) {
      map['bitrate'] = Variable<int>(bitrate);
    }
    if (!nullToAbsent || trackNumber != null) {
      map['track_number'] = Variable<int>(trackNumber);
    }
    if (!nullToAbsent || year != null) {
      map['year'] = Variable<int>(year);
    }
    if (!nullToAbsent || genre != null) {
      map['genre'] = Variable<String>(genre);
    }
    map['folder'] = Variable<String>(folder);
    if (!nullToAbsent || artworkUrl != null) {
      map['artwork_url'] = Variable<String>(artworkUrl);
    }
    map['is_local'] = Variable<bool>(isLocal);
    map['is_favorite'] = Variable<bool>(isFavorite);
    return map;
  }

  SongsCompanion toCompanion(bool nullToAbsent) {
    return SongsCompanion(
      id: Value(id),
      title: Value(title),
      artist: Value(artist),
      album: Value(album),
      duration: Value(duration),
      durationMs: durationMs == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMs),
      path: Value(path),
      bitrate: bitrate == null && nullToAbsent
          ? const Value.absent()
          : Value(bitrate),
      trackNumber: trackNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(trackNumber),
      year: year == null && nullToAbsent ? const Value.absent() : Value(year),
      genre:
          genre == null && nullToAbsent ? const Value.absent() : Value(genre),
      folder: Value(folder),
      artworkUrl: artworkUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(artworkUrl),
      isLocal: Value(isLocal),
      isFavorite: Value(isFavorite),
    );
  }

  factory Song.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Song(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      artist: serializer.fromJson<String>(json['artist']),
      album: serializer.fromJson<String>(json['album']),
      duration: serializer.fromJson<String>(json['duration']),
      durationMs: serializer.fromJson<int?>(json['durationMs']),
      path: serializer.fromJson<String>(json['path']),
      bitrate: serializer.fromJson<int?>(json['bitrate']),
      trackNumber: serializer.fromJson<int?>(json['trackNumber']),
      year: serializer.fromJson<int?>(json['year']),
      genre: serializer.fromJson<String?>(json['genre']),
      folder: serializer.fromJson<String>(json['folder']),
      artworkUrl: serializer.fromJson<String?>(json['artworkUrl']),
      isLocal: serializer.fromJson<bool>(json['isLocal']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'artist': serializer.toJson<String>(artist),
      'album': serializer.toJson<String>(album),
      'duration': serializer.toJson<String>(duration),
      'durationMs': serializer.toJson<int?>(durationMs),
      'path': serializer.toJson<String>(path),
      'bitrate': serializer.toJson<int?>(bitrate),
      'trackNumber': serializer.toJson<int?>(trackNumber),
      'year': serializer.toJson<int?>(year),
      'genre': serializer.toJson<String?>(genre),
      'folder': serializer.toJson<String>(folder),
      'artworkUrl': serializer.toJson<String?>(artworkUrl),
      'isLocal': serializer.toJson<bool>(isLocal),
      'isFavorite': serializer.toJson<bool>(isFavorite),
    };
  }

  Song copyWith(
          {String? id,
          String? title,
          String? artist,
          String? album,
          String? duration,
          Value<int?> durationMs = const Value.absent(),
          String? path,
          Value<int?> bitrate = const Value.absent(),
          Value<int?> trackNumber = const Value.absent(),
          Value<int?> year = const Value.absent(),
          Value<String?> genre = const Value.absent(),
          String? folder,
          Value<String?> artworkUrl = const Value.absent(),
          bool? isLocal,
          bool? isFavorite}) =>
      Song(
        id: id ?? this.id,
        title: title ?? this.title,
        artist: artist ?? this.artist,
        album: album ?? this.album,
        duration: duration ?? this.duration,
        durationMs: durationMs.present ? durationMs.value : this.durationMs,
        path: path ?? this.path,
        bitrate: bitrate.present ? bitrate.value : this.bitrate,
        trackNumber: trackNumber.present ? trackNumber.value : this.trackNumber,
        year: year.present ? year.value : this.year,
        genre: genre.present ? genre.value : this.genre,
        folder: folder ?? this.folder,
        artworkUrl: artworkUrl.present ? artworkUrl.value : this.artworkUrl,
        isLocal: isLocal ?? this.isLocal,
        isFavorite: isFavorite ?? this.isFavorite,
      );
  Song copyWithCompanion(SongsCompanion data) {
    return Song(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      artist: data.artist.present ? data.artist.value : this.artist,
      album: data.album.present ? data.album.value : this.album,
      duration: data.duration.present ? data.duration.value : this.duration,
      durationMs:
          data.durationMs.present ? data.durationMs.value : this.durationMs,
      path: data.path.present ? data.path.value : this.path,
      bitrate: data.bitrate.present ? data.bitrate.value : this.bitrate,
      trackNumber:
          data.trackNumber.present ? data.trackNumber.value : this.trackNumber,
      year: data.year.present ? data.year.value : this.year,
      genre: data.genre.present ? data.genre.value : this.genre,
      folder: data.folder.present ? data.folder.value : this.folder,
      artworkUrl:
          data.artworkUrl.present ? data.artworkUrl.value : this.artworkUrl,
      isLocal: data.isLocal.present ? data.isLocal.value : this.isLocal,
      isFavorite:
          data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Song(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('album: $album, ')
          ..write('duration: $duration, ')
          ..write('durationMs: $durationMs, ')
          ..write('path: $path, ')
          ..write('bitrate: $bitrate, ')
          ..write('trackNumber: $trackNumber, ')
          ..write('year: $year, ')
          ..write('genre: $genre, ')
          ..write('folder: $folder, ')
          ..write('artworkUrl: $artworkUrl, ')
          ..write('isLocal: $isLocal, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      title,
      artist,
      album,
      duration,
      durationMs,
      path,
      bitrate,
      trackNumber,
      year,
      genre,
      folder,
      artworkUrl,
      isLocal,
      isFavorite);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Song &&
          other.id == this.id &&
          other.title == this.title &&
          other.artist == this.artist &&
          other.album == this.album &&
          other.duration == this.duration &&
          other.durationMs == this.durationMs &&
          other.path == this.path &&
          other.bitrate == this.bitrate &&
          other.trackNumber == this.trackNumber &&
          other.year == this.year &&
          other.genre == this.genre &&
          other.folder == this.folder &&
          other.artworkUrl == this.artworkUrl &&
          other.isLocal == this.isLocal &&
          other.isFavorite == this.isFavorite);
}

class SongsCompanion extends UpdateCompanion<Song> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> artist;
  final Value<String> album;
  final Value<String> duration;
  final Value<int?> durationMs;
  final Value<String> path;
  final Value<int?> bitrate;
  final Value<int?> trackNumber;
  final Value<int?> year;
  final Value<String?> genre;
  final Value<String> folder;
  final Value<String?> artworkUrl;
  final Value<bool> isLocal;
  final Value<bool> isFavorite;
  final Value<int> rowid;
  const SongsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.artist = const Value.absent(),
    this.album = const Value.absent(),
    this.duration = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.path = const Value.absent(),
    this.bitrate = const Value.absent(),
    this.trackNumber = const Value.absent(),
    this.year = const Value.absent(),
    this.genre = const Value.absent(),
    this.folder = const Value.absent(),
    this.artworkUrl = const Value.absent(),
    this.isLocal = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SongsCompanion.insert({
    required String id,
    required String title,
    required String artist,
    required String album,
    required String duration,
    this.durationMs = const Value.absent(),
    required String path,
    this.bitrate = const Value.absent(),
    this.trackNumber = const Value.absent(),
    this.year = const Value.absent(),
    this.genre = const Value.absent(),
    required String folder,
    this.artworkUrl = const Value.absent(),
    this.isLocal = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        artist = Value(artist),
        album = Value(album),
        duration = Value(duration),
        path = Value(path),
        folder = Value(folder);
  static Insertable<Song> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? artist,
    Expression<String>? album,
    Expression<String>? duration,
    Expression<int>? durationMs,
    Expression<String>? path,
    Expression<int>? bitrate,
    Expression<int>? trackNumber,
    Expression<int>? year,
    Expression<String>? genre,
    Expression<String>? folder,
    Expression<String>? artworkUrl,
    Expression<bool>? isLocal,
    Expression<bool>? isFavorite,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (artist != null) 'artist': artist,
      if (album != null) 'album': album,
      if (duration != null) 'duration': duration,
      if (durationMs != null) 'duration_ms': durationMs,
      if (path != null) 'path': path,
      if (bitrate != null) 'bitrate': bitrate,
      if (trackNumber != null) 'track_number': trackNumber,
      if (year != null) 'year': year,
      if (genre != null) 'genre': genre,
      if (folder != null) 'folder': folder,
      if (artworkUrl != null) 'artwork_url': artworkUrl,
      if (isLocal != null) 'is_local': isLocal,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SongsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? artist,
      Value<String>? album,
      Value<String>? duration,
      Value<int?>? durationMs,
      Value<String>? path,
      Value<int?>? bitrate,
      Value<int?>? trackNumber,
      Value<int?>? year,
      Value<String?>? genre,
      Value<String>? folder,
      Value<String?>? artworkUrl,
      Value<bool>? isLocal,
      Value<bool>? isFavorite,
      Value<int>? rowid}) {
    return SongsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      duration: duration ?? this.duration,
      durationMs: durationMs ?? this.durationMs,
      path: path ?? this.path,
      bitrate: bitrate ?? this.bitrate,
      trackNumber: trackNumber ?? this.trackNumber,
      year: year ?? this.year,
      genre: genre ?? this.genre,
      folder: folder ?? this.folder,
      artworkUrl: artworkUrl ?? this.artworkUrl,
      isLocal: isLocal ?? this.isLocal,
      isFavorite: isFavorite ?? this.isFavorite,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (artist.present) {
      map['artist'] = Variable<String>(artist.value);
    }
    if (album.present) {
      map['album'] = Variable<String>(album.value);
    }
    if (duration.present) {
      map['duration'] = Variable<String>(duration.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (bitrate.present) {
      map['bitrate'] = Variable<int>(bitrate.value);
    }
    if (trackNumber.present) {
      map['track_number'] = Variable<int>(trackNumber.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (genre.present) {
      map['genre'] = Variable<String>(genre.value);
    }
    if (folder.present) {
      map['folder'] = Variable<String>(folder.value);
    }
    if (artworkUrl.present) {
      map['artwork_url'] = Variable<String>(artworkUrl.value);
    }
    if (isLocal.present) {
      map['is_local'] = Variable<bool>(isLocal.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SongsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('artist: $artist, ')
          ..write('album: $album, ')
          ..write('duration: $duration, ')
          ..write('durationMs: $durationMs, ')
          ..write('path: $path, ')
          ..write('bitrate: $bitrate, ')
          ..write('trackNumber: $trackNumber, ')
          ..write('year: $year, ')
          ..write('genre: $genre, ')
          ..write('folder: $folder, ')
          ..write('artworkUrl: $artworkUrl, ')
          ..write('isLocal: $isLocal, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AlbumsTable extends Albums with TableInfo<$AlbumsTable, Album> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlbumsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _artistMeta = const VerificationMeta('artist');
  @override
  late final GeneratedColumn<String> artist = GeneratedColumn<String>(
      'artist', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _artworkUrlMeta =
      const VerificationMeta('artworkUrl');
  @override
  late final GeneratedColumn<String> artworkUrl = GeneratedColumn<String>(
      'artwork_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _songCountMeta =
      const VerificationMeta('songCount');
  @override
  late final GeneratedColumn<int> songCount = GeneratedColumn<int>(
      'song_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [name, artist, artworkUrl, songCount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'albums';
  @override
  VerificationContext validateIntegrity(Insertable<Album> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('artist')) {
      context.handle(_artistMeta,
          artist.isAcceptableOrUnknown(data['artist']!, _artistMeta));
    } else if (isInserting) {
      context.missing(_artistMeta);
    }
    if (data.containsKey('artwork_url')) {
      context.handle(
          _artworkUrlMeta,
          artworkUrl.isAcceptableOrUnknown(
              data['artwork_url']!, _artworkUrlMeta));
    }
    if (data.containsKey('song_count')) {
      context.handle(_songCountMeta,
          songCount.isAcceptableOrUnknown(data['song_count']!, _songCountMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name, artist};
  @override
  Album map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Album(
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      artist: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}artist'])!,
      artworkUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}artwork_url']),
      songCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}song_count'])!,
    );
  }

  @override
  $AlbumsTable createAlias(String alias) {
    return $AlbumsTable(attachedDatabase, alias);
  }
}

class Album extends DataClass implements Insertable<Album> {
  final String name;
  final String artist;
  final String? artworkUrl;
  final int songCount;
  const Album(
      {required this.name,
      required this.artist,
      this.artworkUrl,
      required this.songCount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['name'] = Variable<String>(name);
    map['artist'] = Variable<String>(artist);
    if (!nullToAbsent || artworkUrl != null) {
      map['artwork_url'] = Variable<String>(artworkUrl);
    }
    map['song_count'] = Variable<int>(songCount);
    return map;
  }

  AlbumsCompanion toCompanion(bool nullToAbsent) {
    return AlbumsCompanion(
      name: Value(name),
      artist: Value(artist),
      artworkUrl: artworkUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(artworkUrl),
      songCount: Value(songCount),
    );
  }

  factory Album.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Album(
      name: serializer.fromJson<String>(json['name']),
      artist: serializer.fromJson<String>(json['artist']),
      artworkUrl: serializer.fromJson<String?>(json['artworkUrl']),
      songCount: serializer.fromJson<int>(json['songCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'artist': serializer.toJson<String>(artist),
      'artworkUrl': serializer.toJson<String?>(artworkUrl),
      'songCount': serializer.toJson<int>(songCount),
    };
  }

  Album copyWith(
          {String? name,
          String? artist,
          Value<String?> artworkUrl = const Value.absent(),
          int? songCount}) =>
      Album(
        name: name ?? this.name,
        artist: artist ?? this.artist,
        artworkUrl: artworkUrl.present ? artworkUrl.value : this.artworkUrl,
        songCount: songCount ?? this.songCount,
      );
  Album copyWithCompanion(AlbumsCompanion data) {
    return Album(
      name: data.name.present ? data.name.value : this.name,
      artist: data.artist.present ? data.artist.value : this.artist,
      artworkUrl:
          data.artworkUrl.present ? data.artworkUrl.value : this.artworkUrl,
      songCount: data.songCount.present ? data.songCount.value : this.songCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Album(')
          ..write('name: $name, ')
          ..write('artist: $artist, ')
          ..write('artworkUrl: $artworkUrl, ')
          ..write('songCount: $songCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(name, artist, artworkUrl, songCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Album &&
          other.name == this.name &&
          other.artist == this.artist &&
          other.artworkUrl == this.artworkUrl &&
          other.songCount == this.songCount);
}

class AlbumsCompanion extends UpdateCompanion<Album> {
  final Value<String> name;
  final Value<String> artist;
  final Value<String?> artworkUrl;
  final Value<int> songCount;
  final Value<int> rowid;
  const AlbumsCompanion({
    this.name = const Value.absent(),
    this.artist = const Value.absent(),
    this.artworkUrl = const Value.absent(),
    this.songCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AlbumsCompanion.insert({
    required String name,
    required String artist,
    this.artworkUrl = const Value.absent(),
    this.songCount = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : name = Value(name),
        artist = Value(artist);
  static Insertable<Album> custom({
    Expression<String>? name,
    Expression<String>? artist,
    Expression<String>? artworkUrl,
    Expression<int>? songCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (artist != null) 'artist': artist,
      if (artworkUrl != null) 'artwork_url': artworkUrl,
      if (songCount != null) 'song_count': songCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AlbumsCompanion copyWith(
      {Value<String>? name,
      Value<String>? artist,
      Value<String?>? artworkUrl,
      Value<int>? songCount,
      Value<int>? rowid}) {
    return AlbumsCompanion(
      name: name ?? this.name,
      artist: artist ?? this.artist,
      artworkUrl: artworkUrl ?? this.artworkUrl,
      songCount: songCount ?? this.songCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (artist.present) {
      map['artist'] = Variable<String>(artist.value);
    }
    if (artworkUrl.present) {
      map['artwork_url'] = Variable<String>(artworkUrl.value);
    }
    if (songCount.present) {
      map['song_count'] = Variable<int>(songCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlbumsCompanion(')
          ..write('name: $name, ')
          ..write('artist: $artist, ')
          ..write('artworkUrl: $artworkUrl, ')
          ..write('songCount: $songCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ArtistsTable extends Artists with TableInfo<$ArtistsTable, Artist> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArtistsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _artworkUrlMeta =
      const VerificationMeta('artworkUrl');
  @override
  late final GeneratedColumn<String> artworkUrl = GeneratedColumn<String>(
      'artwork_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _monthlyListenersMeta =
      const VerificationMeta('monthlyListeners');
  @override
  late final GeneratedColumn<int> monthlyListeners = GeneratedColumn<int>(
      'monthly_listeners', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, artworkUrl, monthlyListeners];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'artists';
  @override
  VerificationContext validateIntegrity(Insertable<Artist> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('artwork_url')) {
      context.handle(
          _artworkUrlMeta,
          artworkUrl.isAcceptableOrUnknown(
              data['artwork_url']!, _artworkUrlMeta));
    }
    if (data.containsKey('monthly_listeners')) {
      context.handle(
          _monthlyListenersMeta,
          monthlyListeners.isAcceptableOrUnknown(
              data['monthly_listeners']!, _monthlyListenersMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Artist map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Artist(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      artworkUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}artwork_url']),
      monthlyListeners: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}monthly_listeners'])!,
    );
  }

  @override
  $ArtistsTable createAlias(String alias) {
    return $ArtistsTable(attachedDatabase, alias);
  }
}

class Artist extends DataClass implements Insertable<Artist> {
  final String id;
  final String name;
  final String? artworkUrl;
  final int monthlyListeners;
  const Artist(
      {required this.id,
      required this.name,
      this.artworkUrl,
      required this.monthlyListeners});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || artworkUrl != null) {
      map['artwork_url'] = Variable<String>(artworkUrl);
    }
    map['monthly_listeners'] = Variable<int>(monthlyListeners);
    return map;
  }

  ArtistsCompanion toCompanion(bool nullToAbsent) {
    return ArtistsCompanion(
      id: Value(id),
      name: Value(name),
      artworkUrl: artworkUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(artworkUrl),
      monthlyListeners: Value(monthlyListeners),
    );
  }

  factory Artist.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Artist(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      artworkUrl: serializer.fromJson<String?>(json['artworkUrl']),
      monthlyListeners: serializer.fromJson<int>(json['monthlyListeners']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'artworkUrl': serializer.toJson<String?>(artworkUrl),
      'monthlyListeners': serializer.toJson<int>(monthlyListeners),
    };
  }

  Artist copyWith(
          {String? id,
          String? name,
          Value<String?> artworkUrl = const Value.absent(),
          int? monthlyListeners}) =>
      Artist(
        id: id ?? this.id,
        name: name ?? this.name,
        artworkUrl: artworkUrl.present ? artworkUrl.value : this.artworkUrl,
        monthlyListeners: monthlyListeners ?? this.monthlyListeners,
      );
  Artist copyWithCompanion(ArtistsCompanion data) {
    return Artist(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      artworkUrl:
          data.artworkUrl.present ? data.artworkUrl.value : this.artworkUrl,
      monthlyListeners: data.monthlyListeners.present
          ? data.monthlyListeners.value
          : this.monthlyListeners,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Artist(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('artworkUrl: $artworkUrl, ')
          ..write('monthlyListeners: $monthlyListeners')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, artworkUrl, monthlyListeners);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Artist &&
          other.id == this.id &&
          other.name == this.name &&
          other.artworkUrl == this.artworkUrl &&
          other.monthlyListeners == this.monthlyListeners);
}

class ArtistsCompanion extends UpdateCompanion<Artist> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> artworkUrl;
  final Value<int> monthlyListeners;
  final Value<int> rowid;
  const ArtistsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.artworkUrl = const Value.absent(),
    this.monthlyListeners = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ArtistsCompanion.insert({
    required String id,
    required String name,
    this.artworkUrl = const Value.absent(),
    this.monthlyListeners = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<Artist> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? artworkUrl,
    Expression<int>? monthlyListeners,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (artworkUrl != null) 'artwork_url': artworkUrl,
      if (monthlyListeners != null) 'monthly_listeners': monthlyListeners,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ArtistsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? artworkUrl,
      Value<int>? monthlyListeners,
      Value<int>? rowid}) {
    return ArtistsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      artworkUrl: artworkUrl ?? this.artworkUrl,
      monthlyListeners: monthlyListeners ?? this.monthlyListeners,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (artworkUrl.present) {
      map['artwork_url'] = Variable<String>(artworkUrl.value);
    }
    if (monthlyListeners.present) {
      map['monthly_listeners'] = Variable<int>(monthlyListeners.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArtistsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('artworkUrl: $artworkUrl, ')
          ..write('monthlyListeners: $monthlyListeners, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GenresTable extends Genres with TableInfo<$GenresTable, Genre> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GenresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'genres';
  @override
  VerificationContext validateIntegrity(Insertable<Genre> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  Genre map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Genre(
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $GenresTable createAlias(String alias) {
    return $GenresTable(attachedDatabase, alias);
  }
}

class Genre extends DataClass implements Insertable<Genre> {
  final String name;
  const Genre({required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['name'] = Variable<String>(name);
    return map;
  }

  GenresCompanion toCompanion(bool nullToAbsent) {
    return GenresCompanion(
      name: Value(name),
    );
  }

  factory Genre.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Genre(
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
    };
  }

  Genre copyWith({String? name}) => Genre(
        name: name ?? this.name,
      );
  Genre copyWithCompanion(GenresCompanion data) {
    return Genre(
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Genre(')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => name.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Genre && other.name == this.name);
}

class GenresCompanion extends UpdateCompanion<Genre> {
  final Value<String> name;
  final Value<int> rowid;
  const GenresCompanion({
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GenresCompanion.insert({
    required String name,
    this.rowid = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Genre> custom({
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GenresCompanion copyWith({Value<String>? name, Value<int>? rowid}) {
    return GenresCompanion(
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GenresCompanion(')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FoldersTable extends Folders with TableInfo<$FoldersTable, Folder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoldersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [path];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'folders';
  @override
  VerificationContext validateIntegrity(Insertable<Folder> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {path};
  @override
  Folder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Folder(
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
    );
  }

  @override
  $FoldersTable createAlias(String alias) {
    return $FoldersTable(attachedDatabase, alias);
  }
}

class Folder extends DataClass implements Insertable<Folder> {
  final String path;
  const Folder({required this.path});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['path'] = Variable<String>(path);
    return map;
  }

  FoldersCompanion toCompanion(bool nullToAbsent) {
    return FoldersCompanion(
      path: Value(path),
    );
  }

  factory Folder.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Folder(
      path: serializer.fromJson<String>(json['path']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'path': serializer.toJson<String>(path),
    };
  }

  Folder copyWith({String? path}) => Folder(
        path: path ?? this.path,
      );
  Folder copyWithCompanion(FoldersCompanion data) {
    return Folder(
      path: data.path.present ? data.path.value : this.path,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Folder(')
          ..write('path: $path')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => path.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Folder && other.path == this.path);
}

class FoldersCompanion extends UpdateCompanion<Folder> {
  final Value<String> path;
  final Value<int> rowid;
  const FoldersCompanion({
    this.path = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FoldersCompanion.insert({
    required String path,
    this.rowid = const Value.absent(),
  }) : path = Value(path);
  static Insertable<Folder> custom({
    Expression<String>? path,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (path != null) 'path': path,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FoldersCompanion copyWith({Value<String>? path, Value<int>? rowid}) {
    return FoldersCompanion(
      path: path ?? this.path,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoldersCompanion(')
          ..write('path: $path, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlaylistsTable extends Playlists
    with TableInfo<$PlaylistsTable, Playlist> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaylistsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _artworkUrlMeta =
      const VerificationMeta('artworkUrl');
  @override
  late final GeneratedColumn<String> artworkUrl = GeneratedColumn<String>(
      'artwork_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _creatorMeta =
      const VerificationMeta('creator');
  @override
  late final GeneratedColumn<String> creator = GeneratedColumn<String>(
      'creator', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, artworkUrl, creator];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'playlists';
  @override
  VerificationContext validateIntegrity(Insertable<Playlist> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('artwork_url')) {
      context.handle(
          _artworkUrlMeta,
          artworkUrl.isAcceptableOrUnknown(
              data['artwork_url']!, _artworkUrlMeta));
    }
    if (data.containsKey('creator')) {
      context.handle(_creatorMeta,
          creator.isAcceptableOrUnknown(data['creator']!, _creatorMeta));
    } else if (isInserting) {
      context.missing(_creatorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Playlist map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Playlist(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      artworkUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}artwork_url']),
      creator: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}creator'])!,
    );
  }

  @override
  $PlaylistsTable createAlias(String alias) {
    return $PlaylistsTable(attachedDatabase, alias);
  }
}

class Playlist extends DataClass implements Insertable<Playlist> {
  final String id;
  final String name;
  final String? description;
  final String? artworkUrl;
  final String creator;
  const Playlist(
      {required this.id,
      required this.name,
      this.description,
      this.artworkUrl,
      required this.creator});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || artworkUrl != null) {
      map['artwork_url'] = Variable<String>(artworkUrl);
    }
    map['creator'] = Variable<String>(creator);
    return map;
  }

  PlaylistsCompanion toCompanion(bool nullToAbsent) {
    return PlaylistsCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      artworkUrl: artworkUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(artworkUrl),
      creator: Value(creator),
    );
  }

  factory Playlist.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Playlist(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      artworkUrl: serializer.fromJson<String?>(json['artworkUrl']),
      creator: serializer.fromJson<String>(json['creator']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'artworkUrl': serializer.toJson<String?>(artworkUrl),
      'creator': serializer.toJson<String>(creator),
    };
  }

  Playlist copyWith(
          {String? id,
          String? name,
          Value<String?> description = const Value.absent(),
          Value<String?> artworkUrl = const Value.absent(),
          String? creator}) =>
      Playlist(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        artworkUrl: artworkUrl.present ? artworkUrl.value : this.artworkUrl,
        creator: creator ?? this.creator,
      );
  Playlist copyWithCompanion(PlaylistsCompanion data) {
    return Playlist(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      artworkUrl:
          data.artworkUrl.present ? data.artworkUrl.value : this.artworkUrl,
      creator: data.creator.present ? data.creator.value : this.creator,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Playlist(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('artworkUrl: $artworkUrl, ')
          ..write('creator: $creator')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, artworkUrl, creator);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Playlist &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.artworkUrl == this.artworkUrl &&
          other.creator == this.creator);
}

class PlaylistsCompanion extends UpdateCompanion<Playlist> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> artworkUrl;
  final Value<String> creator;
  final Value<int> rowid;
  const PlaylistsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.artworkUrl = const Value.absent(),
    this.creator = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlaylistsCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    this.artworkUrl = const Value.absent(),
    required String creator,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        creator = Value(creator);
  static Insertable<Playlist> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? artworkUrl,
    Expression<String>? creator,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (artworkUrl != null) 'artwork_url': artworkUrl,
      if (creator != null) 'creator': creator,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlaylistsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<String?>? artworkUrl,
      Value<String>? creator,
      Value<int>? rowid}) {
    return PlaylistsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      artworkUrl: artworkUrl ?? this.artworkUrl,
      creator: creator ?? this.creator,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (artworkUrl.present) {
      map['artwork_url'] = Variable<String>(artworkUrl.value);
    }
    if (creator.present) {
      map['creator'] = Variable<String>(creator.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('artworkUrl: $artworkUrl, ')
          ..write('creator: $creator, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlaylistSongsTable extends PlaylistSongs
    with TableInfo<$PlaylistSongsTable, PlaylistSong> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaylistSongsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _playlistIdMeta =
      const VerificationMeta('playlistId');
  @override
  late final GeneratedColumn<String> playlistId = GeneratedColumn<String>(
      'playlist_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _songIdMeta = const VerificationMeta('songId');
  @override
  late final GeneratedColumn<String> songId = GeneratedColumn<String>(
      'song_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sequenceMeta =
      const VerificationMeta('sequence');
  @override
  late final GeneratedColumn<int> sequence = GeneratedColumn<int>(
      'sequence', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [playlistId, songId, sequence];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'playlist_songs';
  @override
  VerificationContext validateIntegrity(Insertable<PlaylistSong> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('playlist_id')) {
      context.handle(
          _playlistIdMeta,
          playlistId.isAcceptableOrUnknown(
              data['playlist_id']!, _playlistIdMeta));
    } else if (isInserting) {
      context.missing(_playlistIdMeta);
    }
    if (data.containsKey('song_id')) {
      context.handle(_songIdMeta,
          songId.isAcceptableOrUnknown(data['song_id']!, _songIdMeta));
    } else if (isInserting) {
      context.missing(_songIdMeta);
    }
    if (data.containsKey('sequence')) {
      context.handle(_sequenceMeta,
          sequence.isAcceptableOrUnknown(data['sequence']!, _sequenceMeta));
    } else if (isInserting) {
      context.missing(_sequenceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {playlistId, songId};
  @override
  PlaylistSong map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaylistSong(
      playlistId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}playlist_id'])!,
      songId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}song_id'])!,
      sequence: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sequence'])!,
    );
  }

  @override
  $PlaylistSongsTable createAlias(String alias) {
    return $PlaylistSongsTable(attachedDatabase, alias);
  }
}

class PlaylistSong extends DataClass implements Insertable<PlaylistSong> {
  final String playlistId;
  final String songId;
  final int sequence;
  const PlaylistSong(
      {required this.playlistId, required this.songId, required this.sequence});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['playlist_id'] = Variable<String>(playlistId);
    map['song_id'] = Variable<String>(songId);
    map['sequence'] = Variable<int>(sequence);
    return map;
  }

  PlaylistSongsCompanion toCompanion(bool nullToAbsent) {
    return PlaylistSongsCompanion(
      playlistId: Value(playlistId),
      songId: Value(songId),
      sequence: Value(sequence),
    );
  }

  factory PlaylistSong.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaylistSong(
      playlistId: serializer.fromJson<String>(json['playlistId']),
      songId: serializer.fromJson<String>(json['songId']),
      sequence: serializer.fromJson<int>(json['sequence']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'playlistId': serializer.toJson<String>(playlistId),
      'songId': serializer.toJson<String>(songId),
      'sequence': serializer.toJson<int>(sequence),
    };
  }

  PlaylistSong copyWith({String? playlistId, String? songId, int? sequence}) =>
      PlaylistSong(
        playlistId: playlistId ?? this.playlistId,
        songId: songId ?? this.songId,
        sequence: sequence ?? this.sequence,
      );
  PlaylistSong copyWithCompanion(PlaylistSongsCompanion data) {
    return PlaylistSong(
      playlistId:
          data.playlistId.present ? data.playlistId.value : this.playlistId,
      songId: data.songId.present ? data.songId.value : this.songId,
      sequence: data.sequence.present ? data.sequence.value : this.sequence,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistSong(')
          ..write('playlistId: $playlistId, ')
          ..write('songId: $songId, ')
          ..write('sequence: $sequence')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(playlistId, songId, sequence);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaylistSong &&
          other.playlistId == this.playlistId &&
          other.songId == this.songId &&
          other.sequence == this.sequence);
}

class PlaylistSongsCompanion extends UpdateCompanion<PlaylistSong> {
  final Value<String> playlistId;
  final Value<String> songId;
  final Value<int> sequence;
  final Value<int> rowid;
  const PlaylistSongsCompanion({
    this.playlistId = const Value.absent(),
    this.songId = const Value.absent(),
    this.sequence = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlaylistSongsCompanion.insert({
    required String playlistId,
    required String songId,
    required int sequence,
    this.rowid = const Value.absent(),
  })  : playlistId = Value(playlistId),
        songId = Value(songId),
        sequence = Value(sequence);
  static Insertable<PlaylistSong> custom({
    Expression<String>? playlistId,
    Expression<String>? songId,
    Expression<int>? sequence,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (playlistId != null) 'playlist_id': playlistId,
      if (songId != null) 'song_id': songId,
      if (sequence != null) 'sequence': sequence,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlaylistSongsCompanion copyWith(
      {Value<String>? playlistId,
      Value<String>? songId,
      Value<int>? sequence,
      Value<int>? rowid}) {
    return PlaylistSongsCompanion(
      playlistId: playlistId ?? this.playlistId,
      songId: songId ?? this.songId,
      sequence: sequence ?? this.sequence,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (playlistId.present) {
      map['playlist_id'] = Variable<String>(playlistId.value);
    }
    if (songId.present) {
      map['song_id'] = Variable<String>(songId.value);
    }
    if (sequence.present) {
      map['sequence'] = Variable<int>(sequence.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistSongsCompanion(')
          ..write('playlistId: $playlistId, ')
          ..write('songId: $songId, ')
          ..write('sequence: $sequence, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HistoryTable extends History with TableInfo<$HistoryTable, HistoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _songIdMeta = const VerificationMeta('songId');
  @override
  late final GeneratedColumn<String> songId = GeneratedColumn<String>(
      'song_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _playedAtMeta =
      const VerificationMeta('playedAt');
  @override
  late final GeneratedColumn<DateTime> playedAt = GeneratedColumn<DateTime>(
      'played_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, songId, playedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'history';
  @override
  VerificationContext validateIntegrity(Insertable<HistoryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('song_id')) {
      context.handle(_songIdMeta,
          songId.isAcceptableOrUnknown(data['song_id']!, _songIdMeta));
    } else if (isInserting) {
      context.missing(_songIdMeta);
    }
    if (data.containsKey('played_at')) {
      context.handle(_playedAtMeta,
          playedAt.isAcceptableOrUnknown(data['played_at']!, _playedAtMeta));
    } else if (isInserting) {
      context.missing(_playedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HistoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HistoryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      songId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}song_id'])!,
      playedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}played_at'])!,
    );
  }

  @override
  $HistoryTable createAlias(String alias) {
    return $HistoryTable(attachedDatabase, alias);
  }
}

class HistoryData extends DataClass implements Insertable<HistoryData> {
  final int id;
  final String songId;
  final DateTime playedAt;
  const HistoryData(
      {required this.id, required this.songId, required this.playedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['song_id'] = Variable<String>(songId);
    map['played_at'] = Variable<DateTime>(playedAt);
    return map;
  }

  HistoryCompanion toCompanion(bool nullToAbsent) {
    return HistoryCompanion(
      id: Value(id),
      songId: Value(songId),
      playedAt: Value(playedAt),
    );
  }

  factory HistoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HistoryData(
      id: serializer.fromJson<int>(json['id']),
      songId: serializer.fromJson<String>(json['songId']),
      playedAt: serializer.fromJson<DateTime>(json['playedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'songId': serializer.toJson<String>(songId),
      'playedAt': serializer.toJson<DateTime>(playedAt),
    };
  }

  HistoryData copyWith({int? id, String? songId, DateTime? playedAt}) =>
      HistoryData(
        id: id ?? this.id,
        songId: songId ?? this.songId,
        playedAt: playedAt ?? this.playedAt,
      );
  HistoryData copyWithCompanion(HistoryCompanion data) {
    return HistoryData(
      id: data.id.present ? data.id.value : this.id,
      songId: data.songId.present ? data.songId.value : this.songId,
      playedAt: data.playedAt.present ? data.playedAt.value : this.playedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HistoryData(')
          ..write('id: $id, ')
          ..write('songId: $songId, ')
          ..write('playedAt: $playedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, songId, playedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HistoryData &&
          other.id == this.id &&
          other.songId == this.songId &&
          other.playedAt == this.playedAt);
}

class HistoryCompanion extends UpdateCompanion<HistoryData> {
  final Value<int> id;
  final Value<String> songId;
  final Value<DateTime> playedAt;
  const HistoryCompanion({
    this.id = const Value.absent(),
    this.songId = const Value.absent(),
    this.playedAt = const Value.absent(),
  });
  HistoryCompanion.insert({
    this.id = const Value.absent(),
    required String songId,
    required DateTime playedAt,
  })  : songId = Value(songId),
        playedAt = Value(playedAt);
  static Insertable<HistoryData> custom({
    Expression<int>? id,
    Expression<String>? songId,
    Expression<DateTime>? playedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (songId != null) 'song_id': songId,
      if (playedAt != null) 'played_at': playedAt,
    });
  }

  HistoryCompanion copyWith(
      {Value<int>? id, Value<String>? songId, Value<DateTime>? playedAt}) {
    return HistoryCompanion(
      id: id ?? this.id,
      songId: songId ?? this.songId,
      playedAt: playedAt ?? this.playedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (songId.present) {
      map['song_id'] = Variable<String>(songId.value);
    }
    if (playedAt.present) {
      map['played_at'] = Variable<DateTime>(playedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistoryCompanion(')
          ..write('id: $id, ')
          ..write('songId: $songId, ')
          ..write('playedAt: $playedAt')
          ..write(')'))
        .toString();
  }
}

class $RecentlyPlayedTable extends RecentlyPlayed
    with TableInfo<$RecentlyPlayedTable, RecentlyPlayedData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecentlyPlayedTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _songIdMeta = const VerificationMeta('songId');
  @override
  late final GeneratedColumn<String> songId = GeneratedColumn<String>(
      'song_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _playedAtMeta =
      const VerificationMeta('playedAt');
  @override
  late final GeneratedColumn<DateTime> playedAt = GeneratedColumn<DateTime>(
      'played_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [songId, playedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recently_played';
  @override
  VerificationContext validateIntegrity(Insertable<RecentlyPlayedData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('song_id')) {
      context.handle(_songIdMeta,
          songId.isAcceptableOrUnknown(data['song_id']!, _songIdMeta));
    } else if (isInserting) {
      context.missing(_songIdMeta);
    }
    if (data.containsKey('played_at')) {
      context.handle(_playedAtMeta,
          playedAt.isAcceptableOrUnknown(data['played_at']!, _playedAtMeta));
    } else if (isInserting) {
      context.missing(_playedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {songId};
  @override
  RecentlyPlayedData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecentlyPlayedData(
      songId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}song_id'])!,
      playedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}played_at'])!,
    );
  }

  @override
  $RecentlyPlayedTable createAlias(String alias) {
    return $RecentlyPlayedTable(attachedDatabase, alias);
  }
}

class RecentlyPlayedData extends DataClass
    implements Insertable<RecentlyPlayedData> {
  final String songId;
  final DateTime playedAt;
  const RecentlyPlayedData({required this.songId, required this.playedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['song_id'] = Variable<String>(songId);
    map['played_at'] = Variable<DateTime>(playedAt);
    return map;
  }

  RecentlyPlayedCompanion toCompanion(bool nullToAbsent) {
    return RecentlyPlayedCompanion(
      songId: Value(songId),
      playedAt: Value(playedAt),
    );
  }

  factory RecentlyPlayedData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecentlyPlayedData(
      songId: serializer.fromJson<String>(json['songId']),
      playedAt: serializer.fromJson<DateTime>(json['playedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'songId': serializer.toJson<String>(songId),
      'playedAt': serializer.toJson<DateTime>(playedAt),
    };
  }

  RecentlyPlayedData copyWith({String? songId, DateTime? playedAt}) =>
      RecentlyPlayedData(
        songId: songId ?? this.songId,
        playedAt: playedAt ?? this.playedAt,
      );
  RecentlyPlayedData copyWithCompanion(RecentlyPlayedCompanion data) {
    return RecentlyPlayedData(
      songId: data.songId.present ? data.songId.value : this.songId,
      playedAt: data.playedAt.present ? data.playedAt.value : this.playedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecentlyPlayedData(')
          ..write('songId: $songId, ')
          ..write('playedAt: $playedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(songId, playedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecentlyPlayedData &&
          other.songId == this.songId &&
          other.playedAt == this.playedAt);
}

class RecentlyPlayedCompanion extends UpdateCompanion<RecentlyPlayedData> {
  final Value<String> songId;
  final Value<DateTime> playedAt;
  final Value<int> rowid;
  const RecentlyPlayedCompanion({
    this.songId = const Value.absent(),
    this.playedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecentlyPlayedCompanion.insert({
    required String songId,
    required DateTime playedAt,
    this.rowid = const Value.absent(),
  })  : songId = Value(songId),
        playedAt = Value(playedAt);
  static Insertable<RecentlyPlayedData> custom({
    Expression<String>? songId,
    Expression<DateTime>? playedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (songId != null) 'song_id': songId,
      if (playedAt != null) 'played_at': playedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecentlyPlayedCompanion copyWith(
      {Value<String>? songId, Value<DateTime>? playedAt, Value<int>? rowid}) {
    return RecentlyPlayedCompanion(
      songId: songId ?? this.songId,
      playedAt: playedAt ?? this.playedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (songId.present) {
      map['song_id'] = Variable<String>(songId.value);
    }
    if (playedAt.present) {
      map['played_at'] = Variable<DateTime>(playedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecentlyPlayedCompanion(')
          ..write('songId: $songId, ')
          ..write('playedAt: $playedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QueueItemsTable extends QueueItems
    with TableInfo<$QueueItemsTable, QueueItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QueueItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _songIdMeta = const VerificationMeta('songId');
  @override
  late final GeneratedColumn<String> songId = GeneratedColumn<String>(
      'song_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sequenceMeta =
      const VerificationMeta('sequence');
  @override
  late final GeneratedColumn<int> sequence = GeneratedColumn<int>(
      'sequence', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [songId, sequence];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'queue_items';
  @override
  VerificationContext validateIntegrity(Insertable<QueueItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('song_id')) {
      context.handle(_songIdMeta,
          songId.isAcceptableOrUnknown(data['song_id']!, _songIdMeta));
    } else if (isInserting) {
      context.missing(_songIdMeta);
    }
    if (data.containsKey('sequence')) {
      context.handle(_sequenceMeta,
          sequence.isAcceptableOrUnknown(data['sequence']!, _sequenceMeta));
    } else if (isInserting) {
      context.missing(_sequenceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {songId};
  @override
  QueueItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QueueItem(
      songId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}song_id'])!,
      sequence: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sequence'])!,
    );
  }

  @override
  $QueueItemsTable createAlias(String alias) {
    return $QueueItemsTable(attachedDatabase, alias);
  }
}

class QueueItem extends DataClass implements Insertable<QueueItem> {
  final String songId;
  final int sequence;
  const QueueItem({required this.songId, required this.sequence});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['song_id'] = Variable<String>(songId);
    map['sequence'] = Variable<int>(sequence);
    return map;
  }

  QueueItemsCompanion toCompanion(bool nullToAbsent) {
    return QueueItemsCompanion(
      songId: Value(songId),
      sequence: Value(sequence),
    );
  }

  factory QueueItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QueueItem(
      songId: serializer.fromJson<String>(json['songId']),
      sequence: serializer.fromJson<int>(json['sequence']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'songId': serializer.toJson<String>(songId),
      'sequence': serializer.toJson<int>(sequence),
    };
  }

  QueueItem copyWith({String? songId, int? sequence}) => QueueItem(
        songId: songId ?? this.songId,
        sequence: sequence ?? this.sequence,
      );
  QueueItem copyWithCompanion(QueueItemsCompanion data) {
    return QueueItem(
      songId: data.songId.present ? data.songId.value : this.songId,
      sequence: data.sequence.present ? data.sequence.value : this.sequence,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QueueItem(')
          ..write('songId: $songId, ')
          ..write('sequence: $sequence')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(songId, sequence);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QueueItem &&
          other.songId == this.songId &&
          other.sequence == this.sequence);
}

class QueueItemsCompanion extends UpdateCompanion<QueueItem> {
  final Value<String> songId;
  final Value<int> sequence;
  final Value<int> rowid;
  const QueueItemsCompanion({
    this.songId = const Value.absent(),
    this.sequence = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QueueItemsCompanion.insert({
    required String songId,
    required int sequence,
    this.rowid = const Value.absent(),
  })  : songId = Value(songId),
        sequence = Value(sequence);
  static Insertable<QueueItem> custom({
    Expression<String>? songId,
    Expression<int>? sequence,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (songId != null) 'song_id': songId,
      if (sequence != null) 'sequence': sequence,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QueueItemsCompanion copyWith(
      {Value<String>? songId, Value<int>? sequence, Value<int>? rowid}) {
    return QueueItemsCompanion(
      songId: songId ?? this.songId,
      sequence: sequence ?? this.sequence,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (songId.present) {
      map['song_id'] = Variable<String>(songId.value);
    }
    if (sequence.present) {
      map['sequence'] = Variable<int>(sequence.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QueueItemsCompanion(')
          ..write('songId: $songId, ')
          ..write('sequence: $sequence, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LyricsTableTable extends LyricsTable
    with TableInfo<$LyricsTableTable, LyricsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LyricsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _songIdMeta = const VerificationMeta('songId');
  @override
  late final GeneratedColumn<String> songId = GeneratedColumn<String>(
      'song_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lyricsTextMeta =
      const VerificationMeta('lyricsText');
  @override
  late final GeneratedColumn<String> lyricsText = GeneratedColumn<String>(
      'lyrics_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [songId, lyricsText];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lyrics_table';
  @override
  VerificationContext validateIntegrity(Insertable<LyricsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('song_id')) {
      context.handle(_songIdMeta,
          songId.isAcceptableOrUnknown(data['song_id']!, _songIdMeta));
    } else if (isInserting) {
      context.missing(_songIdMeta);
    }
    if (data.containsKey('lyrics_text')) {
      context.handle(
          _lyricsTextMeta,
          lyricsText.isAcceptableOrUnknown(
              data['lyrics_text']!, _lyricsTextMeta));
    } else if (isInserting) {
      context.missing(_lyricsTextMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {songId};
  @override
  LyricsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LyricsTableData(
      songId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}song_id'])!,
      lyricsText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lyrics_text'])!,
    );
  }

  @override
  $LyricsTableTable createAlias(String alias) {
    return $LyricsTableTable(attachedDatabase, alias);
  }
}

class LyricsTableData extends DataClass implements Insertable<LyricsTableData> {
  final String songId;
  final String lyricsText;
  const LyricsTableData({required this.songId, required this.lyricsText});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['song_id'] = Variable<String>(songId);
    map['lyrics_text'] = Variable<String>(lyricsText);
    return map;
  }

  LyricsTableCompanion toCompanion(bool nullToAbsent) {
    return LyricsTableCompanion(
      songId: Value(songId),
      lyricsText: Value(lyricsText),
    );
  }

  factory LyricsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LyricsTableData(
      songId: serializer.fromJson<String>(json['songId']),
      lyricsText: serializer.fromJson<String>(json['lyricsText']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'songId': serializer.toJson<String>(songId),
      'lyricsText': serializer.toJson<String>(lyricsText),
    };
  }

  LyricsTableData copyWith({String? songId, String? lyricsText}) =>
      LyricsTableData(
        songId: songId ?? this.songId,
        lyricsText: lyricsText ?? this.lyricsText,
      );
  LyricsTableData copyWithCompanion(LyricsTableCompanion data) {
    return LyricsTableData(
      songId: data.songId.present ? data.songId.value : this.songId,
      lyricsText:
          data.lyricsText.present ? data.lyricsText.value : this.lyricsText,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LyricsTableData(')
          ..write('songId: $songId, ')
          ..write('lyricsText: $lyricsText')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(songId, lyricsText);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LyricsTableData &&
          other.songId == this.songId &&
          other.lyricsText == this.lyricsText);
}

class LyricsTableCompanion extends UpdateCompanion<LyricsTableData> {
  final Value<String> songId;
  final Value<String> lyricsText;
  final Value<int> rowid;
  const LyricsTableCompanion({
    this.songId = const Value.absent(),
    this.lyricsText = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LyricsTableCompanion.insert({
    required String songId,
    required String lyricsText,
    this.rowid = const Value.absent(),
  })  : songId = Value(songId),
        lyricsText = Value(lyricsText);
  static Insertable<LyricsTableData> custom({
    Expression<String>? songId,
    Expression<String>? lyricsText,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (songId != null) 'song_id': songId,
      if (lyricsText != null) 'lyrics_text': lyricsText,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LyricsTableCompanion copyWith(
      {Value<String>? songId, Value<String>? lyricsText, Value<int>? rowid}) {
    return LyricsTableCompanion(
      songId: songId ?? this.songId,
      lyricsText: lyricsText ?? this.lyricsText,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (songId.present) {
      map['song_id'] = Variable<String>(songId.value);
    }
    if (lyricsText.present) {
      map['lyrics_text'] = Variable<String>(lyricsText.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LyricsTableCompanion(')
          ..write('songId: $songId, ')
          ..write('lyricsText: $lyricsText, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SleepTimerTableTable extends SleepTimerTable
    with TableInfo<$SleepTimerTableTable, SleepTimerTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SleepTimerTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _durationMinutesMeta =
      const VerificationMeta('durationMinutes');
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
      'duration_minutes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _triggerTimeMeta =
      const VerificationMeta('triggerTime');
  @override
  late final GeneratedColumn<DateTime> triggerTime = GeneratedColumn<DateTime>(
      'trigger_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, durationMinutes, triggerTime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sleep_timer_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<SleepTimerTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
          _durationMinutesMeta,
          durationMinutes.isAcceptableOrUnknown(
              data['duration_minutes']!, _durationMinutesMeta));
    } else if (isInserting) {
      context.missing(_durationMinutesMeta);
    }
    if (data.containsKey('trigger_time')) {
      context.handle(
          _triggerTimeMeta,
          triggerTime.isAcceptableOrUnknown(
              data['trigger_time']!, _triggerTimeMeta));
    } else if (isInserting) {
      context.missing(_triggerTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SleepTimerTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SleepTimerTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      durationMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_minutes'])!,
      triggerTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}trigger_time'])!,
    );
  }

  @override
  $SleepTimerTableTable createAlias(String alias) {
    return $SleepTimerTableTable(attachedDatabase, alias);
  }
}

class SleepTimerTableData extends DataClass
    implements Insertable<SleepTimerTableData> {
  final int id;
  final int durationMinutes;
  final DateTime triggerTime;
  const SleepTimerTableData(
      {required this.id,
      required this.durationMinutes,
      required this.triggerTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['duration_minutes'] = Variable<int>(durationMinutes);
    map['trigger_time'] = Variable<DateTime>(triggerTime);
    return map;
  }

  SleepTimerTableCompanion toCompanion(bool nullToAbsent) {
    return SleepTimerTableCompanion(
      id: Value(id),
      durationMinutes: Value(durationMinutes),
      triggerTime: Value(triggerTime),
    );
  }

  factory SleepTimerTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SleepTimerTableData(
      id: serializer.fromJson<int>(json['id']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
      triggerTime: serializer.fromJson<DateTime>(json['triggerTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
      'triggerTime': serializer.toJson<DateTime>(triggerTime),
    };
  }

  SleepTimerTableData copyWith(
          {int? id, int? durationMinutes, DateTime? triggerTime}) =>
      SleepTimerTableData(
        id: id ?? this.id,
        durationMinutes: durationMinutes ?? this.durationMinutes,
        triggerTime: triggerTime ?? this.triggerTime,
      );
  SleepTimerTableData copyWithCompanion(SleepTimerTableCompanion data) {
    return SleepTimerTableData(
      id: data.id.present ? data.id.value : this.id,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      triggerTime:
          data.triggerTime.present ? data.triggerTime.value : this.triggerTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SleepTimerTableData(')
          ..write('id: $id, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('triggerTime: $triggerTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, durationMinutes, triggerTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SleepTimerTableData &&
          other.id == this.id &&
          other.durationMinutes == this.durationMinutes &&
          other.triggerTime == this.triggerTime);
}

class SleepTimerTableCompanion extends UpdateCompanion<SleepTimerTableData> {
  final Value<int> id;
  final Value<int> durationMinutes;
  final Value<DateTime> triggerTime;
  const SleepTimerTableCompanion({
    this.id = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.triggerTime = const Value.absent(),
  });
  SleepTimerTableCompanion.insert({
    this.id = const Value.absent(),
    required int durationMinutes,
    required DateTime triggerTime,
  })  : durationMinutes = Value(durationMinutes),
        triggerTime = Value(triggerTime);
  static Insertable<SleepTimerTableData> custom({
    Expression<int>? id,
    Expression<int>? durationMinutes,
    Expression<DateTime>? triggerTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (triggerTime != null) 'trigger_time': triggerTime,
    });
  }

  SleepTimerTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? durationMinutes,
      Value<DateTime>? triggerTime}) {
    return SleepTimerTableCompanion(
      id: id ?? this.id,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      triggerTime: triggerTime ?? this.triggerTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (triggerTime.present) {
      map['trigger_time'] = Variable<DateTime>(triggerTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SleepTimerTableCompanion(')
          ..write('id: $id, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('triggerTime: $triggerTime')
          ..write(')'))
        .toString();
  }
}

class $SettingsTableTable extends SettingsTable
    with TableInfo<$SettingsTableTable, SettingsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings_table';
  @override
  VerificationContext validateIntegrity(Insertable<SettingsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SettingsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingsTableData(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $SettingsTableTable createAlias(String alias) {
    return $SettingsTableTable(attachedDatabase, alias);
  }
}

class SettingsTableData extends DataClass
    implements Insertable<SettingsTableData> {
  final String key;
  final String value;
  const SettingsTableData({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  SettingsTableCompanion toCompanion(bool nullToAbsent) {
    return SettingsTableCompanion(
      key: Value(key),
      value: Value(value),
    );
  }

  factory SettingsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingsTableData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  SettingsTableData copyWith({String? key, String? value}) => SettingsTableData(
        key: key ?? this.key,
        value: value ?? this.value,
      );
  SettingsTableData copyWithCompanion(SettingsTableCompanion data) {
    return SettingsTableData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingsTableData(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingsTableData &&
          other.key == this.key &&
          other.value == this.value);
}

class SettingsTableCompanion extends UpdateCompanion<SettingsTableData> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const SettingsTableCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsTableCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value);
  static Insertable<SettingsTableData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsTableCompanion copyWith(
      {Value<String>? key, Value<String>? value, Value<int>? rowid}) {
    return SettingsTableCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsTableCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlaybackStateTableTable extends PlaybackStateTable
    with TableInfo<$PlaybackStateTableTable, PlaybackStateTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaybackStateTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _currentSongIdMeta =
      const VerificationMeta('currentSongId');
  @override
  late final GeneratedColumn<String> currentSongId = GeneratedColumn<String>(
      'current_song_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _currentPositionMsMeta =
      const VerificationMeta('currentPositionMs');
  @override
  late final GeneratedColumn<int> currentPositionMs = GeneratedColumn<int>(
      'current_position_ms', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _queueIndexMeta =
      const VerificationMeta('queueIndex');
  @override
  late final GeneratedColumn<int> queueIndex = GeneratedColumn<int>(
      'queue_index', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isShuffleMeta =
      const VerificationMeta('isShuffle');
  @override
  late final GeneratedColumn<bool> isShuffle = GeneratedColumn<bool>(
      'is_shuffle', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_shuffle" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _repeatModeMeta =
      const VerificationMeta('repeatMode');
  @override
  late final GeneratedColumn<int> repeatMode = GeneratedColumn<int>(
      'repeat_mode', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, currentSongId, currentPositionMs, queueIndex, isShuffle, repeatMode];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'playback_state_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<PlaybackStateTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('current_song_id')) {
      context.handle(
          _currentSongIdMeta,
          currentSongId.isAcceptableOrUnknown(
              data['current_song_id']!, _currentSongIdMeta));
    }
    if (data.containsKey('current_position_ms')) {
      context.handle(
          _currentPositionMsMeta,
          currentPositionMs.isAcceptableOrUnknown(
              data['current_position_ms']!, _currentPositionMsMeta));
    }
    if (data.containsKey('queue_index')) {
      context.handle(
          _queueIndexMeta,
          queueIndex.isAcceptableOrUnknown(
              data['queue_index']!, _queueIndexMeta));
    }
    if (data.containsKey('is_shuffle')) {
      context.handle(_isShuffleMeta,
          isShuffle.isAcceptableOrUnknown(data['is_shuffle']!, _isShuffleMeta));
    }
    if (data.containsKey('repeat_mode')) {
      context.handle(
          _repeatModeMeta,
          repeatMode.isAcceptableOrUnknown(
              data['repeat_mode']!, _repeatModeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlaybackStateTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaybackStateTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      currentSongId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}current_song_id']),
      currentPositionMs: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}current_position_ms'])!,
      queueIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}queue_index'])!,
      isShuffle: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_shuffle'])!,
      repeatMode: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}repeat_mode'])!,
    );
  }

  @override
  $PlaybackStateTableTable createAlias(String alias) {
    return $PlaybackStateTableTable(attachedDatabase, alias);
  }
}

class PlaybackStateTableData extends DataClass
    implements Insertable<PlaybackStateTableData> {
  final int id;
  final String? currentSongId;
  final int currentPositionMs;
  final int queueIndex;
  final bool isShuffle;
  final int repeatMode;
  const PlaybackStateTableData(
      {required this.id,
      this.currentSongId,
      required this.currentPositionMs,
      required this.queueIndex,
      required this.isShuffle,
      required this.repeatMode});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || currentSongId != null) {
      map['current_song_id'] = Variable<String>(currentSongId);
    }
    map['current_position_ms'] = Variable<int>(currentPositionMs);
    map['queue_index'] = Variable<int>(queueIndex);
    map['is_shuffle'] = Variable<bool>(isShuffle);
    map['repeat_mode'] = Variable<int>(repeatMode);
    return map;
  }

  PlaybackStateTableCompanion toCompanion(bool nullToAbsent) {
    return PlaybackStateTableCompanion(
      id: Value(id),
      currentSongId: currentSongId == null && nullToAbsent
          ? const Value.absent()
          : Value(currentSongId),
      currentPositionMs: Value(currentPositionMs),
      queueIndex: Value(queueIndex),
      isShuffle: Value(isShuffle),
      repeatMode: Value(repeatMode),
    );
  }

  factory PlaybackStateTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaybackStateTableData(
      id: serializer.fromJson<int>(json['id']),
      currentSongId: serializer.fromJson<String?>(json['currentSongId']),
      currentPositionMs: serializer.fromJson<int>(json['currentPositionMs']),
      queueIndex: serializer.fromJson<int>(json['queueIndex']),
      isShuffle: serializer.fromJson<bool>(json['isShuffle']),
      repeatMode: serializer.fromJson<int>(json['repeatMode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'currentSongId': serializer.toJson<String?>(currentSongId),
      'currentPositionMs': serializer.toJson<int>(currentPositionMs),
      'queueIndex': serializer.toJson<int>(queueIndex),
      'isShuffle': serializer.toJson<bool>(isShuffle),
      'repeatMode': serializer.toJson<int>(repeatMode),
    };
  }

  PlaybackStateTableData copyWith(
          {int? id,
          Value<String?> currentSongId = const Value.absent(),
          int? currentPositionMs,
          int? queueIndex,
          bool? isShuffle,
          int? repeatMode}) =>
      PlaybackStateTableData(
        id: id ?? this.id,
        currentSongId:
            currentSongId.present ? currentSongId.value : this.currentSongId,
        currentPositionMs: currentPositionMs ?? this.currentPositionMs,
        queueIndex: queueIndex ?? this.queueIndex,
        isShuffle: isShuffle ?? this.isShuffle,
        repeatMode: repeatMode ?? this.repeatMode,
      );
  PlaybackStateTableData copyWithCompanion(PlaybackStateTableCompanion data) {
    return PlaybackStateTableData(
      id: data.id.present ? data.id.value : this.id,
      currentSongId: data.currentSongId.present
          ? data.currentSongId.value
          : this.currentSongId,
      currentPositionMs: data.currentPositionMs.present
          ? data.currentPositionMs.value
          : this.currentPositionMs,
      queueIndex:
          data.queueIndex.present ? data.queueIndex.value : this.queueIndex,
      isShuffle: data.isShuffle.present ? data.isShuffle.value : this.isShuffle,
      repeatMode:
          data.repeatMode.present ? data.repeatMode.value : this.repeatMode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlaybackStateTableData(')
          ..write('id: $id, ')
          ..write('currentSongId: $currentSongId, ')
          ..write('currentPositionMs: $currentPositionMs, ')
          ..write('queueIndex: $queueIndex, ')
          ..write('isShuffle: $isShuffle, ')
          ..write('repeatMode: $repeatMode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, currentSongId, currentPositionMs, queueIndex, isShuffle, repeatMode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaybackStateTableData &&
          other.id == this.id &&
          other.currentSongId == this.currentSongId &&
          other.currentPositionMs == this.currentPositionMs &&
          other.queueIndex == this.queueIndex &&
          other.isShuffle == this.isShuffle &&
          other.repeatMode == this.repeatMode);
}

class PlaybackStateTableCompanion
    extends UpdateCompanion<PlaybackStateTableData> {
  final Value<int> id;
  final Value<String?> currentSongId;
  final Value<int> currentPositionMs;
  final Value<int> queueIndex;
  final Value<bool> isShuffle;
  final Value<int> repeatMode;
  const PlaybackStateTableCompanion({
    this.id = const Value.absent(),
    this.currentSongId = const Value.absent(),
    this.currentPositionMs = const Value.absent(),
    this.queueIndex = const Value.absent(),
    this.isShuffle = const Value.absent(),
    this.repeatMode = const Value.absent(),
  });
  PlaybackStateTableCompanion.insert({
    this.id = const Value.absent(),
    this.currentSongId = const Value.absent(),
    this.currentPositionMs = const Value.absent(),
    this.queueIndex = const Value.absent(),
    this.isShuffle = const Value.absent(),
    this.repeatMode = const Value.absent(),
  });
  static Insertable<PlaybackStateTableData> custom({
    Expression<int>? id,
    Expression<String>? currentSongId,
    Expression<int>? currentPositionMs,
    Expression<int>? queueIndex,
    Expression<bool>? isShuffle,
    Expression<int>? repeatMode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (currentSongId != null) 'current_song_id': currentSongId,
      if (currentPositionMs != null) 'current_position_ms': currentPositionMs,
      if (queueIndex != null) 'queue_index': queueIndex,
      if (isShuffle != null) 'is_shuffle': isShuffle,
      if (repeatMode != null) 'repeat_mode': repeatMode,
    });
  }

  PlaybackStateTableCompanion copyWith(
      {Value<int>? id,
      Value<String?>? currentSongId,
      Value<int>? currentPositionMs,
      Value<int>? queueIndex,
      Value<bool>? isShuffle,
      Value<int>? repeatMode}) {
    return PlaybackStateTableCompanion(
      id: id ?? this.id,
      currentSongId: currentSongId ?? this.currentSongId,
      currentPositionMs: currentPositionMs ?? this.currentPositionMs,
      queueIndex: queueIndex ?? this.queueIndex,
      isShuffle: isShuffle ?? this.isShuffle,
      repeatMode: repeatMode ?? this.repeatMode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (currentSongId.present) {
      map['current_song_id'] = Variable<String>(currentSongId.value);
    }
    if (currentPositionMs.present) {
      map['current_position_ms'] = Variable<int>(currentPositionMs.value);
    }
    if (queueIndex.present) {
      map['queue_index'] = Variable<int>(queueIndex.value);
    }
    if (isShuffle.present) {
      map['is_shuffle'] = Variable<bool>(isShuffle.value);
    }
    if (repeatMode.present) {
      map['repeat_mode'] = Variable<int>(repeatMode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaybackStateTableCompanion(')
          ..write('id: $id, ')
          ..write('currentSongId: $currentSongId, ')
          ..write('currentPositionMs: $currentPositionMs, ')
          ..write('queueIndex: $queueIndex, ')
          ..write('isShuffle: $isShuffle, ')
          ..write('repeatMode: $repeatMode')
          ..write(')'))
        .toString();
  }
}

class $ArtworkCacheTableTable extends ArtworkCacheTable
    with TableInfo<$ArtworkCacheTableTable, ArtworkCacheTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArtworkCacheTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dominantColorMeta =
      const VerificationMeta('dominantColor');
  @override
  late final GeneratedColumn<String> dominantColor = GeneratedColumn<String>(
      'dominant_color', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _vibrantColorMeta =
      const VerificationMeta('vibrantColor');
  @override
  late final GeneratedColumn<String> vibrantColor = GeneratedColumn<String>(
      'vibrant_color', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _darkColorMeta =
      const VerificationMeta('darkColor');
  @override
  late final GeneratedColumn<String> darkColor = GeneratedColumn<String>(
      'dark_color', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, path, dominantColor, vibrantColor, darkColor, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'artwork_cache_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<ArtworkCacheTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('dominant_color')) {
      context.handle(
          _dominantColorMeta,
          dominantColor.isAcceptableOrUnknown(
              data['dominant_color']!, _dominantColorMeta));
    }
    if (data.containsKey('vibrant_color')) {
      context.handle(
          _vibrantColorMeta,
          vibrantColor.isAcceptableOrUnknown(
              data['vibrant_color']!, _vibrantColorMeta));
    }
    if (data.containsKey('dark_color')) {
      context.handle(_darkColorMeta,
          darkColor.isAcceptableOrUnknown(data['dark_color']!, _darkColorMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ArtworkCacheTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ArtworkCacheTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      dominantColor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dominant_color']),
      vibrantColor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}vibrant_color']),
      darkColor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dark_color']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ArtworkCacheTableTable createAlias(String alias) {
    return $ArtworkCacheTableTable(attachedDatabase, alias);
  }
}

class ArtworkCacheTableData extends DataClass
    implements Insertable<ArtworkCacheTableData> {
  final String id;
  final String path;
  final String? dominantColor;
  final String? vibrantColor;
  final String? darkColor;
  final DateTime updatedAt;
  const ArtworkCacheTableData(
      {required this.id,
      required this.path,
      this.dominantColor,
      this.vibrantColor,
      this.darkColor,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['path'] = Variable<String>(path);
    if (!nullToAbsent || dominantColor != null) {
      map['dominant_color'] = Variable<String>(dominantColor);
    }
    if (!nullToAbsent || vibrantColor != null) {
      map['vibrant_color'] = Variable<String>(vibrantColor);
    }
    if (!nullToAbsent || darkColor != null) {
      map['dark_color'] = Variable<String>(darkColor);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ArtworkCacheTableCompanion toCompanion(bool nullToAbsent) {
    return ArtworkCacheTableCompanion(
      id: Value(id),
      path: Value(path),
      dominantColor: dominantColor == null && nullToAbsent
          ? const Value.absent()
          : Value(dominantColor),
      vibrantColor: vibrantColor == null && nullToAbsent
          ? const Value.absent()
          : Value(vibrantColor),
      darkColor: darkColor == null && nullToAbsent
          ? const Value.absent()
          : Value(darkColor),
      updatedAt: Value(updatedAt),
    );
  }

  factory ArtworkCacheTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ArtworkCacheTableData(
      id: serializer.fromJson<String>(json['id']),
      path: serializer.fromJson<String>(json['path']),
      dominantColor: serializer.fromJson<String?>(json['dominantColor']),
      vibrantColor: serializer.fromJson<String?>(json['vibrantColor']),
      darkColor: serializer.fromJson<String?>(json['darkColor']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'path': serializer.toJson<String>(path),
      'dominantColor': serializer.toJson<String?>(dominantColor),
      'vibrantColor': serializer.toJson<String?>(vibrantColor),
      'darkColor': serializer.toJson<String?>(darkColor),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ArtworkCacheTableData copyWith(
          {String? id,
          String? path,
          Value<String?> dominantColor = const Value.absent(),
          Value<String?> vibrantColor = const Value.absent(),
          Value<String?> darkColor = const Value.absent(),
          DateTime? updatedAt}) =>
      ArtworkCacheTableData(
        id: id ?? this.id,
        path: path ?? this.path,
        dominantColor:
            dominantColor.present ? dominantColor.value : this.dominantColor,
        vibrantColor:
            vibrantColor.present ? vibrantColor.value : this.vibrantColor,
        darkColor: darkColor.present ? darkColor.value : this.darkColor,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  ArtworkCacheTableData copyWithCompanion(ArtworkCacheTableCompanion data) {
    return ArtworkCacheTableData(
      id: data.id.present ? data.id.value : this.id,
      path: data.path.present ? data.path.value : this.path,
      dominantColor: data.dominantColor.present
          ? data.dominantColor.value
          : this.dominantColor,
      vibrantColor: data.vibrantColor.present
          ? data.vibrantColor.value
          : this.vibrantColor,
      darkColor: data.darkColor.present ? data.darkColor.value : this.darkColor,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ArtworkCacheTableData(')
          ..write('id: $id, ')
          ..write('path: $path, ')
          ..write('dominantColor: $dominantColor, ')
          ..write('vibrantColor: $vibrantColor, ')
          ..write('darkColor: $darkColor, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, path, dominantColor, vibrantColor, darkColor, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ArtworkCacheTableData &&
          other.id == this.id &&
          other.path == this.path &&
          other.dominantColor == this.dominantColor &&
          other.vibrantColor == this.vibrantColor &&
          other.darkColor == this.darkColor &&
          other.updatedAt == this.updatedAt);
}

class ArtworkCacheTableCompanion
    extends UpdateCompanion<ArtworkCacheTableData> {
  final Value<String> id;
  final Value<String> path;
  final Value<String?> dominantColor;
  final Value<String?> vibrantColor;
  final Value<String?> darkColor;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ArtworkCacheTableCompanion({
    this.id = const Value.absent(),
    this.path = const Value.absent(),
    this.dominantColor = const Value.absent(),
    this.vibrantColor = const Value.absent(),
    this.darkColor = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ArtworkCacheTableCompanion.insert({
    required String id,
    required String path,
    this.dominantColor = const Value.absent(),
    this.vibrantColor = const Value.absent(),
    this.darkColor = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        path = Value(path),
        updatedAt = Value(updatedAt);
  static Insertable<ArtworkCacheTableData> custom({
    Expression<String>? id,
    Expression<String>? path,
    Expression<String>? dominantColor,
    Expression<String>? vibrantColor,
    Expression<String>? darkColor,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (path != null) 'path': path,
      if (dominantColor != null) 'dominant_color': dominantColor,
      if (vibrantColor != null) 'vibrant_color': vibrantColor,
      if (darkColor != null) 'dark_color': darkColor,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ArtworkCacheTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? path,
      Value<String?>? dominantColor,
      Value<String?>? vibrantColor,
      Value<String?>? darkColor,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return ArtworkCacheTableCompanion(
      id: id ?? this.id,
      path: path ?? this.path,
      dominantColor: dominantColor ?? this.dominantColor,
      vibrantColor: vibrantColor ?? this.vibrantColor,
      darkColor: darkColor ?? this.darkColor,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (dominantColor.present) {
      map['dominant_color'] = Variable<String>(dominantColor.value);
    }
    if (vibrantColor.present) {
      map['vibrant_color'] = Variable<String>(vibrantColor.value);
    }
    if (darkColor.present) {
      map['dark_color'] = Variable<String>(darkColor.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArtworkCacheTableCompanion(')
          ..write('id: $id, ')
          ..write('path: $path, ')
          ..write('dominantColor: $dominantColor, ')
          ..write('vibrantColor: $vibrantColor, ')
          ..write('darkColor: $darkColor, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SongsTable songs = $SongsTable(this);
  late final $AlbumsTable albums = $AlbumsTable(this);
  late final $ArtistsTable artists = $ArtistsTable(this);
  late final $GenresTable genres = $GenresTable(this);
  late final $FoldersTable folders = $FoldersTable(this);
  late final $PlaylistsTable playlists = $PlaylistsTable(this);
  late final $PlaylistSongsTable playlistSongs = $PlaylistSongsTable(this);
  late final $HistoryTable history = $HistoryTable(this);
  late final $RecentlyPlayedTable recentlyPlayed = $RecentlyPlayedTable(this);
  late final $QueueItemsTable queueItems = $QueueItemsTable(this);
  late final $LyricsTableTable lyricsTable = $LyricsTableTable(this);
  late final $SleepTimerTableTable sleepTimerTable =
      $SleepTimerTableTable(this);
  late final $SettingsTableTable settingsTable = $SettingsTableTable(this);
  late final $PlaybackStateTableTable playbackStateTable =
      $PlaybackStateTableTable(this);
  late final $ArtworkCacheTableTable artworkCacheTable =
      $ArtworkCacheTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        songs,
        albums,
        artists,
        genres,
        folders,
        playlists,
        playlistSongs,
        history,
        recentlyPlayed,
        queueItems,
        lyricsTable,
        sleepTimerTable,
        settingsTable,
        playbackStateTable,
        artworkCacheTable
      ];
}

typedef $$SongsTableCreateCompanionBuilder = SongsCompanion Function({
  required String id,
  required String title,
  required String artist,
  required String album,
  required String duration,
  Value<int?> durationMs,
  required String path,
  Value<int?> bitrate,
  Value<int?> trackNumber,
  Value<int?> year,
  Value<String?> genre,
  required String folder,
  Value<String?> artworkUrl,
  Value<bool> isLocal,
  Value<bool> isFavorite,
  Value<int> rowid,
});
typedef $$SongsTableUpdateCompanionBuilder = SongsCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String> artist,
  Value<String> album,
  Value<String> duration,
  Value<int?> durationMs,
  Value<String> path,
  Value<int?> bitrate,
  Value<int?> trackNumber,
  Value<int?> year,
  Value<String?> genre,
  Value<String> folder,
  Value<String?> artworkUrl,
  Value<bool> isLocal,
  Value<bool> isFavorite,
  Value<int> rowid,
});

class $$SongsTableFilterComposer extends Composer<_$AppDatabase, $SongsTable> {
  $$SongsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get artist => $composableBuilder(
      column: $table.artist, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get album => $composableBuilder(
      column: $table.album, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationMs => $composableBuilder(
      column: $table.durationMs, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get bitrate => $composableBuilder(
      column: $table.bitrate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get trackNumber => $composableBuilder(
      column: $table.trackNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get year => $composableBuilder(
      column: $table.year, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get genre => $composableBuilder(
      column: $table.genre, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get folder => $composableBuilder(
      column: $table.folder, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get artworkUrl => $composableBuilder(
      column: $table.artworkUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isLocal => $composableBuilder(
      column: $table.isLocal, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnFilters(column));
}

class $$SongsTableOrderingComposer
    extends Composer<_$AppDatabase, $SongsTable> {
  $$SongsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get artist => $composableBuilder(
      column: $table.artist, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get album => $composableBuilder(
      column: $table.album, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationMs => $composableBuilder(
      column: $table.durationMs, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get bitrate => $composableBuilder(
      column: $table.bitrate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get trackNumber => $composableBuilder(
      column: $table.trackNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get year => $composableBuilder(
      column: $table.year, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get genre => $composableBuilder(
      column: $table.genre, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get folder => $composableBuilder(
      column: $table.folder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get artworkUrl => $composableBuilder(
      column: $table.artworkUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isLocal => $composableBuilder(
      column: $table.isLocal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnOrderings(column));
}

class $$SongsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SongsTable> {
  $$SongsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get artist =>
      $composableBuilder(column: $table.artist, builder: (column) => column);

  GeneratedColumn<String> get album =>
      $composableBuilder(column: $table.album, builder: (column) => column);

  GeneratedColumn<String> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<int> get durationMs => $composableBuilder(
      column: $table.durationMs, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<int> get bitrate =>
      $composableBuilder(column: $table.bitrate, builder: (column) => column);

  GeneratedColumn<int> get trackNumber => $composableBuilder(
      column: $table.trackNumber, builder: (column) => column);

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<String> get genre =>
      $composableBuilder(column: $table.genre, builder: (column) => column);

  GeneratedColumn<String> get folder =>
      $composableBuilder(column: $table.folder, builder: (column) => column);

  GeneratedColumn<String> get artworkUrl => $composableBuilder(
      column: $table.artworkUrl, builder: (column) => column);

  GeneratedColumn<bool> get isLocal =>
      $composableBuilder(column: $table.isLocal, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => column);
}

class $$SongsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SongsTable,
    Song,
    $$SongsTableFilterComposer,
    $$SongsTableOrderingComposer,
    $$SongsTableAnnotationComposer,
    $$SongsTableCreateCompanionBuilder,
    $$SongsTableUpdateCompanionBuilder,
    (Song, BaseReferences<_$AppDatabase, $SongsTable, Song>),
    Song,
    PrefetchHooks Function()> {
  $$SongsTableTableManager(_$AppDatabase db, $SongsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SongsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SongsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SongsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> artist = const Value.absent(),
            Value<String> album = const Value.absent(),
            Value<String> duration = const Value.absent(),
            Value<int?> durationMs = const Value.absent(),
            Value<String> path = const Value.absent(),
            Value<int?> bitrate = const Value.absent(),
            Value<int?> trackNumber = const Value.absent(),
            Value<int?> year = const Value.absent(),
            Value<String?> genre = const Value.absent(),
            Value<String> folder = const Value.absent(),
            Value<String?> artworkUrl = const Value.absent(),
            Value<bool> isLocal = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SongsCompanion(
            id: id,
            title: title,
            artist: artist,
            album: album,
            duration: duration,
            durationMs: durationMs,
            path: path,
            bitrate: bitrate,
            trackNumber: trackNumber,
            year: year,
            genre: genre,
            folder: folder,
            artworkUrl: artworkUrl,
            isLocal: isLocal,
            isFavorite: isFavorite,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required String artist,
            required String album,
            required String duration,
            Value<int?> durationMs = const Value.absent(),
            required String path,
            Value<int?> bitrate = const Value.absent(),
            Value<int?> trackNumber = const Value.absent(),
            Value<int?> year = const Value.absent(),
            Value<String?> genre = const Value.absent(),
            required String folder,
            Value<String?> artworkUrl = const Value.absent(),
            Value<bool> isLocal = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SongsCompanion.insert(
            id: id,
            title: title,
            artist: artist,
            album: album,
            duration: duration,
            durationMs: durationMs,
            path: path,
            bitrate: bitrate,
            trackNumber: trackNumber,
            year: year,
            genre: genre,
            folder: folder,
            artworkUrl: artworkUrl,
            isLocal: isLocal,
            isFavorite: isFavorite,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SongsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SongsTable,
    Song,
    $$SongsTableFilterComposer,
    $$SongsTableOrderingComposer,
    $$SongsTableAnnotationComposer,
    $$SongsTableCreateCompanionBuilder,
    $$SongsTableUpdateCompanionBuilder,
    (Song, BaseReferences<_$AppDatabase, $SongsTable, Song>),
    Song,
    PrefetchHooks Function()>;
typedef $$AlbumsTableCreateCompanionBuilder = AlbumsCompanion Function({
  required String name,
  required String artist,
  Value<String?> artworkUrl,
  Value<int> songCount,
  Value<int> rowid,
});
typedef $$AlbumsTableUpdateCompanionBuilder = AlbumsCompanion Function({
  Value<String> name,
  Value<String> artist,
  Value<String?> artworkUrl,
  Value<int> songCount,
  Value<int> rowid,
});

class $$AlbumsTableFilterComposer
    extends Composer<_$AppDatabase, $AlbumsTable> {
  $$AlbumsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get artist => $composableBuilder(
      column: $table.artist, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get artworkUrl => $composableBuilder(
      column: $table.artworkUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get songCount => $composableBuilder(
      column: $table.songCount, builder: (column) => ColumnFilters(column));
}

class $$AlbumsTableOrderingComposer
    extends Composer<_$AppDatabase, $AlbumsTable> {
  $$AlbumsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get artist => $composableBuilder(
      column: $table.artist, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get artworkUrl => $composableBuilder(
      column: $table.artworkUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get songCount => $composableBuilder(
      column: $table.songCount, builder: (column) => ColumnOrderings(column));
}

class $$AlbumsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AlbumsTable> {
  $$AlbumsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get artist =>
      $composableBuilder(column: $table.artist, builder: (column) => column);

  GeneratedColumn<String> get artworkUrl => $composableBuilder(
      column: $table.artworkUrl, builder: (column) => column);

  GeneratedColumn<int> get songCount =>
      $composableBuilder(column: $table.songCount, builder: (column) => column);
}

class $$AlbumsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AlbumsTable,
    Album,
    $$AlbumsTableFilterComposer,
    $$AlbumsTableOrderingComposer,
    $$AlbumsTableAnnotationComposer,
    $$AlbumsTableCreateCompanionBuilder,
    $$AlbumsTableUpdateCompanionBuilder,
    (Album, BaseReferences<_$AppDatabase, $AlbumsTable, Album>),
    Album,
    PrefetchHooks Function()> {
  $$AlbumsTableTableManager(_$AppDatabase db, $AlbumsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AlbumsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AlbumsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AlbumsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> name = const Value.absent(),
            Value<String> artist = const Value.absent(),
            Value<String?> artworkUrl = const Value.absent(),
            Value<int> songCount = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AlbumsCompanion(
            name: name,
            artist: artist,
            artworkUrl: artworkUrl,
            songCount: songCount,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String name,
            required String artist,
            Value<String?> artworkUrl = const Value.absent(),
            Value<int> songCount = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AlbumsCompanion.insert(
            name: name,
            artist: artist,
            artworkUrl: artworkUrl,
            songCount: songCount,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AlbumsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AlbumsTable,
    Album,
    $$AlbumsTableFilterComposer,
    $$AlbumsTableOrderingComposer,
    $$AlbumsTableAnnotationComposer,
    $$AlbumsTableCreateCompanionBuilder,
    $$AlbumsTableUpdateCompanionBuilder,
    (Album, BaseReferences<_$AppDatabase, $AlbumsTable, Album>),
    Album,
    PrefetchHooks Function()>;
typedef $$ArtistsTableCreateCompanionBuilder = ArtistsCompanion Function({
  required String id,
  required String name,
  Value<String?> artworkUrl,
  Value<int> monthlyListeners,
  Value<int> rowid,
});
typedef $$ArtistsTableUpdateCompanionBuilder = ArtistsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> artworkUrl,
  Value<int> monthlyListeners,
  Value<int> rowid,
});

class $$ArtistsTableFilterComposer
    extends Composer<_$AppDatabase, $ArtistsTable> {
  $$ArtistsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get artworkUrl => $composableBuilder(
      column: $table.artworkUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get monthlyListeners => $composableBuilder(
      column: $table.monthlyListeners,
      builder: (column) => ColumnFilters(column));
}

class $$ArtistsTableOrderingComposer
    extends Composer<_$AppDatabase, $ArtistsTable> {
  $$ArtistsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get artworkUrl => $composableBuilder(
      column: $table.artworkUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get monthlyListeners => $composableBuilder(
      column: $table.monthlyListeners,
      builder: (column) => ColumnOrderings(column));
}

class $$ArtistsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ArtistsTable> {
  $$ArtistsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get artworkUrl => $composableBuilder(
      column: $table.artworkUrl, builder: (column) => column);

  GeneratedColumn<int> get monthlyListeners => $composableBuilder(
      column: $table.monthlyListeners, builder: (column) => column);
}

class $$ArtistsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ArtistsTable,
    Artist,
    $$ArtistsTableFilterComposer,
    $$ArtistsTableOrderingComposer,
    $$ArtistsTableAnnotationComposer,
    $$ArtistsTableCreateCompanionBuilder,
    $$ArtistsTableUpdateCompanionBuilder,
    (Artist, BaseReferences<_$AppDatabase, $ArtistsTable, Artist>),
    Artist,
    PrefetchHooks Function()> {
  $$ArtistsTableTableManager(_$AppDatabase db, $ArtistsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ArtistsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ArtistsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ArtistsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> artworkUrl = const Value.absent(),
            Value<int> monthlyListeners = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ArtistsCompanion(
            id: id,
            name: name,
            artworkUrl: artworkUrl,
            monthlyListeners: monthlyListeners,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> artworkUrl = const Value.absent(),
            Value<int> monthlyListeners = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ArtistsCompanion.insert(
            id: id,
            name: name,
            artworkUrl: artworkUrl,
            monthlyListeners: monthlyListeners,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ArtistsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ArtistsTable,
    Artist,
    $$ArtistsTableFilterComposer,
    $$ArtistsTableOrderingComposer,
    $$ArtistsTableAnnotationComposer,
    $$ArtistsTableCreateCompanionBuilder,
    $$ArtistsTableUpdateCompanionBuilder,
    (Artist, BaseReferences<_$AppDatabase, $ArtistsTable, Artist>),
    Artist,
    PrefetchHooks Function()>;
typedef $$GenresTableCreateCompanionBuilder = GenresCompanion Function({
  required String name,
  Value<int> rowid,
});
typedef $$GenresTableUpdateCompanionBuilder = GenresCompanion Function({
  Value<String> name,
  Value<int> rowid,
});

class $$GenresTableFilterComposer
    extends Composer<_$AppDatabase, $GenresTable> {
  $$GenresTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));
}

class $$GenresTableOrderingComposer
    extends Composer<_$AppDatabase, $GenresTable> {
  $$GenresTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));
}

class $$GenresTableAnnotationComposer
    extends Composer<_$AppDatabase, $GenresTable> {
  $$GenresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);
}

class $$GenresTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GenresTable,
    Genre,
    $$GenresTableFilterComposer,
    $$GenresTableOrderingComposer,
    $$GenresTableAnnotationComposer,
    $$GenresTableCreateCompanionBuilder,
    $$GenresTableUpdateCompanionBuilder,
    (Genre, BaseReferences<_$AppDatabase, $GenresTable, Genre>),
    Genre,
    PrefetchHooks Function()> {
  $$GenresTableTableManager(_$AppDatabase db, $GenresTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GenresTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GenresTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GenresTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> name = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GenresCompanion(
            name: name,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String name,
            Value<int> rowid = const Value.absent(),
          }) =>
              GenresCompanion.insert(
            name: name,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$GenresTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GenresTable,
    Genre,
    $$GenresTableFilterComposer,
    $$GenresTableOrderingComposer,
    $$GenresTableAnnotationComposer,
    $$GenresTableCreateCompanionBuilder,
    $$GenresTableUpdateCompanionBuilder,
    (Genre, BaseReferences<_$AppDatabase, $GenresTable, Genre>),
    Genre,
    PrefetchHooks Function()>;
typedef $$FoldersTableCreateCompanionBuilder = FoldersCompanion Function({
  required String path,
  Value<int> rowid,
});
typedef $$FoldersTableUpdateCompanionBuilder = FoldersCompanion Function({
  Value<String> path,
  Value<int> rowid,
});

class $$FoldersTableFilterComposer
    extends Composer<_$AppDatabase, $FoldersTable> {
  $$FoldersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnFilters(column));
}

class $$FoldersTableOrderingComposer
    extends Composer<_$AppDatabase, $FoldersTable> {
  $$FoldersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnOrderings(column));
}

class $$FoldersTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoldersTable> {
  $$FoldersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);
}

class $$FoldersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FoldersTable,
    Folder,
    $$FoldersTableFilterComposer,
    $$FoldersTableOrderingComposer,
    $$FoldersTableAnnotationComposer,
    $$FoldersTableCreateCompanionBuilder,
    $$FoldersTableUpdateCompanionBuilder,
    (Folder, BaseReferences<_$AppDatabase, $FoldersTable, Folder>),
    Folder,
    PrefetchHooks Function()> {
  $$FoldersTableTableManager(_$AppDatabase db, $FoldersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoldersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoldersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoldersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> path = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FoldersCompanion(
            path: path,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String path,
            Value<int> rowid = const Value.absent(),
          }) =>
              FoldersCompanion.insert(
            path: path,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FoldersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FoldersTable,
    Folder,
    $$FoldersTableFilterComposer,
    $$FoldersTableOrderingComposer,
    $$FoldersTableAnnotationComposer,
    $$FoldersTableCreateCompanionBuilder,
    $$FoldersTableUpdateCompanionBuilder,
    (Folder, BaseReferences<_$AppDatabase, $FoldersTable, Folder>),
    Folder,
    PrefetchHooks Function()>;
typedef $$PlaylistsTableCreateCompanionBuilder = PlaylistsCompanion Function({
  required String id,
  required String name,
  Value<String?> description,
  Value<String?> artworkUrl,
  required String creator,
  Value<int> rowid,
});
typedef $$PlaylistsTableUpdateCompanionBuilder = PlaylistsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> description,
  Value<String?> artworkUrl,
  Value<String> creator,
  Value<int> rowid,
});

class $$PlaylistsTableFilterComposer
    extends Composer<_$AppDatabase, $PlaylistsTable> {
  $$PlaylistsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get artworkUrl => $composableBuilder(
      column: $table.artworkUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get creator => $composableBuilder(
      column: $table.creator, builder: (column) => ColumnFilters(column));
}

class $$PlaylistsTableOrderingComposer
    extends Composer<_$AppDatabase, $PlaylistsTable> {
  $$PlaylistsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get artworkUrl => $composableBuilder(
      column: $table.artworkUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get creator => $composableBuilder(
      column: $table.creator, builder: (column) => ColumnOrderings(column));
}

class $$PlaylistsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlaylistsTable> {
  $$PlaylistsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get artworkUrl => $composableBuilder(
      column: $table.artworkUrl, builder: (column) => column);

  GeneratedColumn<String> get creator =>
      $composableBuilder(column: $table.creator, builder: (column) => column);
}

class $$PlaylistsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PlaylistsTable,
    Playlist,
    $$PlaylistsTableFilterComposer,
    $$PlaylistsTableOrderingComposer,
    $$PlaylistsTableAnnotationComposer,
    $$PlaylistsTableCreateCompanionBuilder,
    $$PlaylistsTableUpdateCompanionBuilder,
    (Playlist, BaseReferences<_$AppDatabase, $PlaylistsTable, Playlist>),
    Playlist,
    PrefetchHooks Function()> {
  $$PlaylistsTableTableManager(_$AppDatabase db, $PlaylistsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlaylistsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlaylistsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlaylistsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> artworkUrl = const Value.absent(),
            Value<String> creator = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PlaylistsCompanion(
            id: id,
            name: name,
            description: description,
            artworkUrl: artworkUrl,
            creator: creator,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> description = const Value.absent(),
            Value<String?> artworkUrl = const Value.absent(),
            required String creator,
            Value<int> rowid = const Value.absent(),
          }) =>
              PlaylistsCompanion.insert(
            id: id,
            name: name,
            description: description,
            artworkUrl: artworkUrl,
            creator: creator,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PlaylistsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PlaylistsTable,
    Playlist,
    $$PlaylistsTableFilterComposer,
    $$PlaylistsTableOrderingComposer,
    $$PlaylistsTableAnnotationComposer,
    $$PlaylistsTableCreateCompanionBuilder,
    $$PlaylistsTableUpdateCompanionBuilder,
    (Playlist, BaseReferences<_$AppDatabase, $PlaylistsTable, Playlist>),
    Playlist,
    PrefetchHooks Function()>;
typedef $$PlaylistSongsTableCreateCompanionBuilder = PlaylistSongsCompanion
    Function({
  required String playlistId,
  required String songId,
  required int sequence,
  Value<int> rowid,
});
typedef $$PlaylistSongsTableUpdateCompanionBuilder = PlaylistSongsCompanion
    Function({
  Value<String> playlistId,
  Value<String> songId,
  Value<int> sequence,
  Value<int> rowid,
});

class $$PlaylistSongsTableFilterComposer
    extends Composer<_$AppDatabase, $PlaylistSongsTable> {
  $$PlaylistSongsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get playlistId => $composableBuilder(
      column: $table.playlistId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get songId => $composableBuilder(
      column: $table.songId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sequence => $composableBuilder(
      column: $table.sequence, builder: (column) => ColumnFilters(column));
}

class $$PlaylistSongsTableOrderingComposer
    extends Composer<_$AppDatabase, $PlaylistSongsTable> {
  $$PlaylistSongsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get playlistId => $composableBuilder(
      column: $table.playlistId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get songId => $composableBuilder(
      column: $table.songId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sequence => $composableBuilder(
      column: $table.sequence, builder: (column) => ColumnOrderings(column));
}

class $$PlaylistSongsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlaylistSongsTable> {
  $$PlaylistSongsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get playlistId => $composableBuilder(
      column: $table.playlistId, builder: (column) => column);

  GeneratedColumn<String> get songId =>
      $composableBuilder(column: $table.songId, builder: (column) => column);

  GeneratedColumn<int> get sequence =>
      $composableBuilder(column: $table.sequence, builder: (column) => column);
}

class $$PlaylistSongsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PlaylistSongsTable,
    PlaylistSong,
    $$PlaylistSongsTableFilterComposer,
    $$PlaylistSongsTableOrderingComposer,
    $$PlaylistSongsTableAnnotationComposer,
    $$PlaylistSongsTableCreateCompanionBuilder,
    $$PlaylistSongsTableUpdateCompanionBuilder,
    (
      PlaylistSong,
      BaseReferences<_$AppDatabase, $PlaylistSongsTable, PlaylistSong>
    ),
    PlaylistSong,
    PrefetchHooks Function()> {
  $$PlaylistSongsTableTableManager(_$AppDatabase db, $PlaylistSongsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlaylistSongsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlaylistSongsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlaylistSongsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> playlistId = const Value.absent(),
            Value<String> songId = const Value.absent(),
            Value<int> sequence = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PlaylistSongsCompanion(
            playlistId: playlistId,
            songId: songId,
            sequence: sequence,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String playlistId,
            required String songId,
            required int sequence,
            Value<int> rowid = const Value.absent(),
          }) =>
              PlaylistSongsCompanion.insert(
            playlistId: playlistId,
            songId: songId,
            sequence: sequence,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PlaylistSongsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PlaylistSongsTable,
    PlaylistSong,
    $$PlaylistSongsTableFilterComposer,
    $$PlaylistSongsTableOrderingComposer,
    $$PlaylistSongsTableAnnotationComposer,
    $$PlaylistSongsTableCreateCompanionBuilder,
    $$PlaylistSongsTableUpdateCompanionBuilder,
    (
      PlaylistSong,
      BaseReferences<_$AppDatabase, $PlaylistSongsTable, PlaylistSong>
    ),
    PlaylistSong,
    PrefetchHooks Function()>;
typedef $$HistoryTableCreateCompanionBuilder = HistoryCompanion Function({
  Value<int> id,
  required String songId,
  required DateTime playedAt,
});
typedef $$HistoryTableUpdateCompanionBuilder = HistoryCompanion Function({
  Value<int> id,
  Value<String> songId,
  Value<DateTime> playedAt,
});

class $$HistoryTableFilterComposer
    extends Composer<_$AppDatabase, $HistoryTable> {
  $$HistoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get songId => $composableBuilder(
      column: $table.songId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get playedAt => $composableBuilder(
      column: $table.playedAt, builder: (column) => ColumnFilters(column));
}

class $$HistoryTableOrderingComposer
    extends Composer<_$AppDatabase, $HistoryTable> {
  $$HistoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get songId => $composableBuilder(
      column: $table.songId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get playedAt => $composableBuilder(
      column: $table.playedAt, builder: (column) => ColumnOrderings(column));
}

class $$HistoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $HistoryTable> {
  $$HistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get songId =>
      $composableBuilder(column: $table.songId, builder: (column) => column);

  GeneratedColumn<DateTime> get playedAt =>
      $composableBuilder(column: $table.playedAt, builder: (column) => column);
}

class $$HistoryTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HistoryTable,
    HistoryData,
    $$HistoryTableFilterComposer,
    $$HistoryTableOrderingComposer,
    $$HistoryTableAnnotationComposer,
    $$HistoryTableCreateCompanionBuilder,
    $$HistoryTableUpdateCompanionBuilder,
    (HistoryData, BaseReferences<_$AppDatabase, $HistoryTable, HistoryData>),
    HistoryData,
    PrefetchHooks Function()> {
  $$HistoryTableTableManager(_$AppDatabase db, $HistoryTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HistoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> songId = const Value.absent(),
            Value<DateTime> playedAt = const Value.absent(),
          }) =>
              HistoryCompanion(
            id: id,
            songId: songId,
            playedAt: playedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String songId,
            required DateTime playedAt,
          }) =>
              HistoryCompanion.insert(
            id: id,
            songId: songId,
            playedAt: playedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$HistoryTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HistoryTable,
    HistoryData,
    $$HistoryTableFilterComposer,
    $$HistoryTableOrderingComposer,
    $$HistoryTableAnnotationComposer,
    $$HistoryTableCreateCompanionBuilder,
    $$HistoryTableUpdateCompanionBuilder,
    (HistoryData, BaseReferences<_$AppDatabase, $HistoryTable, HistoryData>),
    HistoryData,
    PrefetchHooks Function()>;
typedef $$RecentlyPlayedTableCreateCompanionBuilder = RecentlyPlayedCompanion
    Function({
  required String songId,
  required DateTime playedAt,
  Value<int> rowid,
});
typedef $$RecentlyPlayedTableUpdateCompanionBuilder = RecentlyPlayedCompanion
    Function({
  Value<String> songId,
  Value<DateTime> playedAt,
  Value<int> rowid,
});

class $$RecentlyPlayedTableFilterComposer
    extends Composer<_$AppDatabase, $RecentlyPlayedTable> {
  $$RecentlyPlayedTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get songId => $composableBuilder(
      column: $table.songId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get playedAt => $composableBuilder(
      column: $table.playedAt, builder: (column) => ColumnFilters(column));
}

class $$RecentlyPlayedTableOrderingComposer
    extends Composer<_$AppDatabase, $RecentlyPlayedTable> {
  $$RecentlyPlayedTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get songId => $composableBuilder(
      column: $table.songId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get playedAt => $composableBuilder(
      column: $table.playedAt, builder: (column) => ColumnOrderings(column));
}

class $$RecentlyPlayedTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecentlyPlayedTable> {
  $$RecentlyPlayedTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get songId =>
      $composableBuilder(column: $table.songId, builder: (column) => column);

  GeneratedColumn<DateTime> get playedAt =>
      $composableBuilder(column: $table.playedAt, builder: (column) => column);
}

class $$RecentlyPlayedTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RecentlyPlayedTable,
    RecentlyPlayedData,
    $$RecentlyPlayedTableFilterComposer,
    $$RecentlyPlayedTableOrderingComposer,
    $$RecentlyPlayedTableAnnotationComposer,
    $$RecentlyPlayedTableCreateCompanionBuilder,
    $$RecentlyPlayedTableUpdateCompanionBuilder,
    (
      RecentlyPlayedData,
      BaseReferences<_$AppDatabase, $RecentlyPlayedTable, RecentlyPlayedData>
    ),
    RecentlyPlayedData,
    PrefetchHooks Function()> {
  $$RecentlyPlayedTableTableManager(
      _$AppDatabase db, $RecentlyPlayedTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecentlyPlayedTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecentlyPlayedTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecentlyPlayedTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> songId = const Value.absent(),
            Value<DateTime> playedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RecentlyPlayedCompanion(
            songId: songId,
            playedAt: playedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String songId,
            required DateTime playedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              RecentlyPlayedCompanion.insert(
            songId: songId,
            playedAt: playedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RecentlyPlayedTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RecentlyPlayedTable,
    RecentlyPlayedData,
    $$RecentlyPlayedTableFilterComposer,
    $$RecentlyPlayedTableOrderingComposer,
    $$RecentlyPlayedTableAnnotationComposer,
    $$RecentlyPlayedTableCreateCompanionBuilder,
    $$RecentlyPlayedTableUpdateCompanionBuilder,
    (
      RecentlyPlayedData,
      BaseReferences<_$AppDatabase, $RecentlyPlayedTable, RecentlyPlayedData>
    ),
    RecentlyPlayedData,
    PrefetchHooks Function()>;
typedef $$QueueItemsTableCreateCompanionBuilder = QueueItemsCompanion Function({
  required String songId,
  required int sequence,
  Value<int> rowid,
});
typedef $$QueueItemsTableUpdateCompanionBuilder = QueueItemsCompanion Function({
  Value<String> songId,
  Value<int> sequence,
  Value<int> rowid,
});

class $$QueueItemsTableFilterComposer
    extends Composer<_$AppDatabase, $QueueItemsTable> {
  $$QueueItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get songId => $composableBuilder(
      column: $table.songId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sequence => $composableBuilder(
      column: $table.sequence, builder: (column) => ColumnFilters(column));
}

class $$QueueItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $QueueItemsTable> {
  $$QueueItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get songId => $composableBuilder(
      column: $table.songId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sequence => $composableBuilder(
      column: $table.sequence, builder: (column) => ColumnOrderings(column));
}

class $$QueueItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $QueueItemsTable> {
  $$QueueItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get songId =>
      $composableBuilder(column: $table.songId, builder: (column) => column);

  GeneratedColumn<int> get sequence =>
      $composableBuilder(column: $table.sequence, builder: (column) => column);
}

class $$QueueItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $QueueItemsTable,
    QueueItem,
    $$QueueItemsTableFilterComposer,
    $$QueueItemsTableOrderingComposer,
    $$QueueItemsTableAnnotationComposer,
    $$QueueItemsTableCreateCompanionBuilder,
    $$QueueItemsTableUpdateCompanionBuilder,
    (QueueItem, BaseReferences<_$AppDatabase, $QueueItemsTable, QueueItem>),
    QueueItem,
    PrefetchHooks Function()> {
  $$QueueItemsTableTableManager(_$AppDatabase db, $QueueItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QueueItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QueueItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QueueItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> songId = const Value.absent(),
            Value<int> sequence = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              QueueItemsCompanion(
            songId: songId,
            sequence: sequence,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String songId,
            required int sequence,
            Value<int> rowid = const Value.absent(),
          }) =>
              QueueItemsCompanion.insert(
            songId: songId,
            sequence: sequence,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$QueueItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $QueueItemsTable,
    QueueItem,
    $$QueueItemsTableFilterComposer,
    $$QueueItemsTableOrderingComposer,
    $$QueueItemsTableAnnotationComposer,
    $$QueueItemsTableCreateCompanionBuilder,
    $$QueueItemsTableUpdateCompanionBuilder,
    (QueueItem, BaseReferences<_$AppDatabase, $QueueItemsTable, QueueItem>),
    QueueItem,
    PrefetchHooks Function()>;
typedef $$LyricsTableTableCreateCompanionBuilder = LyricsTableCompanion
    Function({
  required String songId,
  required String lyricsText,
  Value<int> rowid,
});
typedef $$LyricsTableTableUpdateCompanionBuilder = LyricsTableCompanion
    Function({
  Value<String> songId,
  Value<String> lyricsText,
  Value<int> rowid,
});

class $$LyricsTableTableFilterComposer
    extends Composer<_$AppDatabase, $LyricsTableTable> {
  $$LyricsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get songId => $composableBuilder(
      column: $table.songId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lyricsText => $composableBuilder(
      column: $table.lyricsText, builder: (column) => ColumnFilters(column));
}

class $$LyricsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $LyricsTableTable> {
  $$LyricsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get songId => $composableBuilder(
      column: $table.songId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lyricsText => $composableBuilder(
      column: $table.lyricsText, builder: (column) => ColumnOrderings(column));
}

class $$LyricsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $LyricsTableTable> {
  $$LyricsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get songId =>
      $composableBuilder(column: $table.songId, builder: (column) => column);

  GeneratedColumn<String> get lyricsText => $composableBuilder(
      column: $table.lyricsText, builder: (column) => column);
}

class $$LyricsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LyricsTableTable,
    LyricsTableData,
    $$LyricsTableTableFilterComposer,
    $$LyricsTableTableOrderingComposer,
    $$LyricsTableTableAnnotationComposer,
    $$LyricsTableTableCreateCompanionBuilder,
    $$LyricsTableTableUpdateCompanionBuilder,
    (
      LyricsTableData,
      BaseReferences<_$AppDatabase, $LyricsTableTable, LyricsTableData>
    ),
    LyricsTableData,
    PrefetchHooks Function()> {
  $$LyricsTableTableTableManager(_$AppDatabase db, $LyricsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LyricsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LyricsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LyricsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> songId = const Value.absent(),
            Value<String> lyricsText = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LyricsTableCompanion(
            songId: songId,
            lyricsText: lyricsText,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String songId,
            required String lyricsText,
            Value<int> rowid = const Value.absent(),
          }) =>
              LyricsTableCompanion.insert(
            songId: songId,
            lyricsText: lyricsText,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LyricsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LyricsTableTable,
    LyricsTableData,
    $$LyricsTableTableFilterComposer,
    $$LyricsTableTableOrderingComposer,
    $$LyricsTableTableAnnotationComposer,
    $$LyricsTableTableCreateCompanionBuilder,
    $$LyricsTableTableUpdateCompanionBuilder,
    (
      LyricsTableData,
      BaseReferences<_$AppDatabase, $LyricsTableTable, LyricsTableData>
    ),
    LyricsTableData,
    PrefetchHooks Function()>;
typedef $$SleepTimerTableTableCreateCompanionBuilder = SleepTimerTableCompanion
    Function({
  Value<int> id,
  required int durationMinutes,
  required DateTime triggerTime,
});
typedef $$SleepTimerTableTableUpdateCompanionBuilder = SleepTimerTableCompanion
    Function({
  Value<int> id,
  Value<int> durationMinutes,
  Value<DateTime> triggerTime,
});

class $$SleepTimerTableTableFilterComposer
    extends Composer<_$AppDatabase, $SleepTimerTableTable> {
  $$SleepTimerTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get triggerTime => $composableBuilder(
      column: $table.triggerTime, builder: (column) => ColumnFilters(column));
}

class $$SleepTimerTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SleepTimerTableTable> {
  $$SleepTimerTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get triggerTime => $composableBuilder(
      column: $table.triggerTime, builder: (column) => ColumnOrderings(column));
}

class $$SleepTimerTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SleepTimerTableTable> {
  $$SleepTimerTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes, builder: (column) => column);

  GeneratedColumn<DateTime> get triggerTime => $composableBuilder(
      column: $table.triggerTime, builder: (column) => column);
}

class $$SleepTimerTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SleepTimerTableTable,
    SleepTimerTableData,
    $$SleepTimerTableTableFilterComposer,
    $$SleepTimerTableTableOrderingComposer,
    $$SleepTimerTableTableAnnotationComposer,
    $$SleepTimerTableTableCreateCompanionBuilder,
    $$SleepTimerTableTableUpdateCompanionBuilder,
    (
      SleepTimerTableData,
      BaseReferences<_$AppDatabase, $SleepTimerTableTable, SleepTimerTableData>
    ),
    SleepTimerTableData,
    PrefetchHooks Function()> {
  $$SleepTimerTableTableTableManager(
      _$AppDatabase db, $SleepTimerTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SleepTimerTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SleepTimerTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SleepTimerTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> durationMinutes = const Value.absent(),
            Value<DateTime> triggerTime = const Value.absent(),
          }) =>
              SleepTimerTableCompanion(
            id: id,
            durationMinutes: durationMinutes,
            triggerTime: triggerTime,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int durationMinutes,
            required DateTime triggerTime,
          }) =>
              SleepTimerTableCompanion.insert(
            id: id,
            durationMinutes: durationMinutes,
            triggerTime: triggerTime,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SleepTimerTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SleepTimerTableTable,
    SleepTimerTableData,
    $$SleepTimerTableTableFilterComposer,
    $$SleepTimerTableTableOrderingComposer,
    $$SleepTimerTableTableAnnotationComposer,
    $$SleepTimerTableTableCreateCompanionBuilder,
    $$SleepTimerTableTableUpdateCompanionBuilder,
    (
      SleepTimerTableData,
      BaseReferences<_$AppDatabase, $SleepTimerTableTable, SleepTimerTableData>
    ),
    SleepTimerTableData,
    PrefetchHooks Function()>;
typedef $$SettingsTableTableCreateCompanionBuilder = SettingsTableCompanion
    Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$SettingsTableTableUpdateCompanionBuilder = SettingsTableCompanion
    Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$SettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTableTable> {
  $$SettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));
}

class $$SettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTableTable> {
  $$SettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));
}

class $$SettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTableTable> {
  $$SettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$SettingsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SettingsTableTable,
    SettingsTableData,
    $$SettingsTableTableFilterComposer,
    $$SettingsTableTableOrderingComposer,
    $$SettingsTableTableAnnotationComposer,
    $$SettingsTableTableCreateCompanionBuilder,
    $$SettingsTableTableUpdateCompanionBuilder,
    (
      SettingsTableData,
      BaseReferences<_$AppDatabase, $SettingsTableTable, SettingsTableData>
    ),
    SettingsTableData,
    PrefetchHooks Function()> {
  $$SettingsTableTableTableManager(_$AppDatabase db, $SettingsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SettingsTableCompanion(
            key: key,
            value: value,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) =>
              SettingsTableCompanion.insert(
            key: key,
            value: value,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SettingsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SettingsTableTable,
    SettingsTableData,
    $$SettingsTableTableFilterComposer,
    $$SettingsTableTableOrderingComposer,
    $$SettingsTableTableAnnotationComposer,
    $$SettingsTableTableCreateCompanionBuilder,
    $$SettingsTableTableUpdateCompanionBuilder,
    (
      SettingsTableData,
      BaseReferences<_$AppDatabase, $SettingsTableTable, SettingsTableData>
    ),
    SettingsTableData,
    PrefetchHooks Function()>;
typedef $$PlaybackStateTableTableCreateCompanionBuilder
    = PlaybackStateTableCompanion Function({
  Value<int> id,
  Value<String?> currentSongId,
  Value<int> currentPositionMs,
  Value<int> queueIndex,
  Value<bool> isShuffle,
  Value<int> repeatMode,
});
typedef $$PlaybackStateTableTableUpdateCompanionBuilder
    = PlaybackStateTableCompanion Function({
  Value<int> id,
  Value<String?> currentSongId,
  Value<int> currentPositionMs,
  Value<int> queueIndex,
  Value<bool> isShuffle,
  Value<int> repeatMode,
});

class $$PlaybackStateTableTableFilterComposer
    extends Composer<_$AppDatabase, $PlaybackStateTableTable> {
  $$PlaybackStateTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currentSongId => $composableBuilder(
      column: $table.currentSongId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentPositionMs => $composableBuilder(
      column: $table.currentPositionMs,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get queueIndex => $composableBuilder(
      column: $table.queueIndex, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isShuffle => $composableBuilder(
      column: $table.isShuffle, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get repeatMode => $composableBuilder(
      column: $table.repeatMode, builder: (column) => ColumnFilters(column));
}

class $$PlaybackStateTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PlaybackStateTableTable> {
  $$PlaybackStateTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currentSongId => $composableBuilder(
      column: $table.currentSongId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentPositionMs => $composableBuilder(
      column: $table.currentPositionMs,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get queueIndex => $composableBuilder(
      column: $table.queueIndex, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isShuffle => $composableBuilder(
      column: $table.isShuffle, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get repeatMode => $composableBuilder(
      column: $table.repeatMode, builder: (column) => ColumnOrderings(column));
}

class $$PlaybackStateTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlaybackStateTableTable> {
  $$PlaybackStateTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get currentSongId => $composableBuilder(
      column: $table.currentSongId, builder: (column) => column);

  GeneratedColumn<int> get currentPositionMs => $composableBuilder(
      column: $table.currentPositionMs, builder: (column) => column);

  GeneratedColumn<int> get queueIndex => $composableBuilder(
      column: $table.queueIndex, builder: (column) => column);

  GeneratedColumn<bool> get isShuffle =>
      $composableBuilder(column: $table.isShuffle, builder: (column) => column);

  GeneratedColumn<int> get repeatMode => $composableBuilder(
      column: $table.repeatMode, builder: (column) => column);
}

class $$PlaybackStateTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PlaybackStateTableTable,
    PlaybackStateTableData,
    $$PlaybackStateTableTableFilterComposer,
    $$PlaybackStateTableTableOrderingComposer,
    $$PlaybackStateTableTableAnnotationComposer,
    $$PlaybackStateTableTableCreateCompanionBuilder,
    $$PlaybackStateTableTableUpdateCompanionBuilder,
    (
      PlaybackStateTableData,
      BaseReferences<_$AppDatabase, $PlaybackStateTableTable,
          PlaybackStateTableData>
    ),
    PlaybackStateTableData,
    PrefetchHooks Function()> {
  $$PlaybackStateTableTableTableManager(
      _$AppDatabase db, $PlaybackStateTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlaybackStateTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlaybackStateTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlaybackStateTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> currentSongId = const Value.absent(),
            Value<int> currentPositionMs = const Value.absent(),
            Value<int> queueIndex = const Value.absent(),
            Value<bool> isShuffle = const Value.absent(),
            Value<int> repeatMode = const Value.absent(),
          }) =>
              PlaybackStateTableCompanion(
            id: id,
            currentSongId: currentSongId,
            currentPositionMs: currentPositionMs,
            queueIndex: queueIndex,
            isShuffle: isShuffle,
            repeatMode: repeatMode,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> currentSongId = const Value.absent(),
            Value<int> currentPositionMs = const Value.absent(),
            Value<int> queueIndex = const Value.absent(),
            Value<bool> isShuffle = const Value.absent(),
            Value<int> repeatMode = const Value.absent(),
          }) =>
              PlaybackStateTableCompanion.insert(
            id: id,
            currentSongId: currentSongId,
            currentPositionMs: currentPositionMs,
            queueIndex: queueIndex,
            isShuffle: isShuffle,
            repeatMode: repeatMode,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PlaybackStateTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PlaybackStateTableTable,
    PlaybackStateTableData,
    $$PlaybackStateTableTableFilterComposer,
    $$PlaybackStateTableTableOrderingComposer,
    $$PlaybackStateTableTableAnnotationComposer,
    $$PlaybackStateTableTableCreateCompanionBuilder,
    $$PlaybackStateTableTableUpdateCompanionBuilder,
    (
      PlaybackStateTableData,
      BaseReferences<_$AppDatabase, $PlaybackStateTableTable,
          PlaybackStateTableData>
    ),
    PlaybackStateTableData,
    PrefetchHooks Function()>;
typedef $$ArtworkCacheTableTableCreateCompanionBuilder
    = ArtworkCacheTableCompanion Function({
  required String id,
  required String path,
  Value<String?> dominantColor,
  Value<String?> vibrantColor,
  Value<String?> darkColor,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$ArtworkCacheTableTableUpdateCompanionBuilder
    = ArtworkCacheTableCompanion Function({
  Value<String> id,
  Value<String> path,
  Value<String?> dominantColor,
  Value<String?> vibrantColor,
  Value<String?> darkColor,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$ArtworkCacheTableTableFilterComposer
    extends Composer<_$AppDatabase, $ArtworkCacheTableTable> {
  $$ArtworkCacheTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dominantColor => $composableBuilder(
      column: $table.dominantColor, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get vibrantColor => $composableBuilder(
      column: $table.vibrantColor, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get darkColor => $composableBuilder(
      column: $table.darkColor, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$ArtworkCacheTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ArtworkCacheTableTable> {
  $$ArtworkCacheTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dominantColor => $composableBuilder(
      column: $table.dominantColor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get vibrantColor => $composableBuilder(
      column: $table.vibrantColor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get darkColor => $composableBuilder(
      column: $table.darkColor, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ArtworkCacheTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ArtworkCacheTableTable> {
  $$ArtworkCacheTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<String> get dominantColor => $composableBuilder(
      column: $table.dominantColor, builder: (column) => column);

  GeneratedColumn<String> get vibrantColor => $composableBuilder(
      column: $table.vibrantColor, builder: (column) => column);

  GeneratedColumn<String> get darkColor =>
      $composableBuilder(column: $table.darkColor, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ArtworkCacheTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ArtworkCacheTableTable,
    ArtworkCacheTableData,
    $$ArtworkCacheTableTableFilterComposer,
    $$ArtworkCacheTableTableOrderingComposer,
    $$ArtworkCacheTableTableAnnotationComposer,
    $$ArtworkCacheTableTableCreateCompanionBuilder,
    $$ArtworkCacheTableTableUpdateCompanionBuilder,
    (
      ArtworkCacheTableData,
      BaseReferences<_$AppDatabase, $ArtworkCacheTableTable,
          ArtworkCacheTableData>
    ),
    ArtworkCacheTableData,
    PrefetchHooks Function()> {
  $$ArtworkCacheTableTableTableManager(
      _$AppDatabase db, $ArtworkCacheTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ArtworkCacheTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ArtworkCacheTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ArtworkCacheTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> path = const Value.absent(),
            Value<String?> dominantColor = const Value.absent(),
            Value<String?> vibrantColor = const Value.absent(),
            Value<String?> darkColor = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ArtworkCacheTableCompanion(
            id: id,
            path: path,
            dominantColor: dominantColor,
            vibrantColor: vibrantColor,
            darkColor: darkColor,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String path,
            Value<String?> dominantColor = const Value.absent(),
            Value<String?> vibrantColor = const Value.absent(),
            Value<String?> darkColor = const Value.absent(),
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              ArtworkCacheTableCompanion.insert(
            id: id,
            path: path,
            dominantColor: dominantColor,
            vibrantColor: vibrantColor,
            darkColor: darkColor,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ArtworkCacheTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ArtworkCacheTableTable,
    ArtworkCacheTableData,
    $$ArtworkCacheTableTableFilterComposer,
    $$ArtworkCacheTableTableOrderingComposer,
    $$ArtworkCacheTableTableAnnotationComposer,
    $$ArtworkCacheTableTableCreateCompanionBuilder,
    $$ArtworkCacheTableTableUpdateCompanionBuilder,
    (
      ArtworkCacheTableData,
      BaseReferences<_$AppDatabase, $ArtworkCacheTableTable,
          ArtworkCacheTableData>
    ),
    ArtworkCacheTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SongsTableTableManager get songs =>
      $$SongsTableTableManager(_db, _db.songs);
  $$AlbumsTableTableManager get albums =>
      $$AlbumsTableTableManager(_db, _db.albums);
  $$ArtistsTableTableManager get artists =>
      $$ArtistsTableTableManager(_db, _db.artists);
  $$GenresTableTableManager get genres =>
      $$GenresTableTableManager(_db, _db.genres);
  $$FoldersTableTableManager get folders =>
      $$FoldersTableTableManager(_db, _db.folders);
  $$PlaylistsTableTableManager get playlists =>
      $$PlaylistsTableTableManager(_db, _db.playlists);
  $$PlaylistSongsTableTableManager get playlistSongs =>
      $$PlaylistSongsTableTableManager(_db, _db.playlistSongs);
  $$HistoryTableTableManager get history =>
      $$HistoryTableTableManager(_db, _db.history);
  $$RecentlyPlayedTableTableManager get recentlyPlayed =>
      $$RecentlyPlayedTableTableManager(_db, _db.recentlyPlayed);
  $$QueueItemsTableTableManager get queueItems =>
      $$QueueItemsTableTableManager(_db, _db.queueItems);
  $$LyricsTableTableTableManager get lyricsTable =>
      $$LyricsTableTableTableManager(_db, _db.lyricsTable);
  $$SleepTimerTableTableTableManager get sleepTimerTable =>
      $$SleepTimerTableTableTableManager(_db, _db.sleepTimerTable);
  $$SettingsTableTableTableManager get settingsTable =>
      $$SettingsTableTableTableManager(_db, _db.settingsTable);
  $$PlaybackStateTableTableTableManager get playbackStateTable =>
      $$PlaybackStateTableTableTableManager(_db, _db.playbackStateTable);
  $$ArtworkCacheTableTableTableManager get artworkCacheTable =>
      $$ArtworkCacheTableTableTableManager(_db, _db.artworkCacheTable);
}
