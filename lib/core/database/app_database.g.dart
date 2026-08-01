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

class $DownloadsTable extends Downloads
    with TableInfo<$DownloadsTable, Download> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DownloadsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _songIdMeta = const VerificationMeta('songId');
  @override
  late final GeneratedColumn<String> songId = GeneratedColumn<String>(
      'song_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _providerIdMeta =
      const VerificationMeta('providerId');
  @override
  late final GeneratedColumn<String> providerId = GeneratedColumn<String>(
      'provider_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
      'status', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _progressMeta =
      const VerificationMeta('progress');
  @override
  late final GeneratedColumn<double> progress = GeneratedColumn<double>(
      'progress', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, songId, providerId, path, status, progress, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'downloads';
  @override
  VerificationContext validateIntegrity(Insertable<Download> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('song_id')) {
      context.handle(_songIdMeta,
          songId.isAcceptableOrUnknown(data['song_id']!, _songIdMeta));
    } else if (isInserting) {
      context.missing(_songIdMeta);
    }
    if (data.containsKey('provider_id')) {
      context.handle(
          _providerIdMeta,
          providerId.isAcceptableOrUnknown(
              data['provider_id']!, _providerIdMeta));
    } else if (isInserting) {
      context.missing(_providerIdMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('progress')) {
      context.handle(_progressMeta,
          progress.isAcceptableOrUnknown(data['progress']!, _progressMeta));
    } else if (isInserting) {
      context.missing(_progressMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Download map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Download(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      songId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}song_id'])!,
      providerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}provider_id'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status'])!,
      progress: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}progress'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $DownloadsTable createAlias(String alias) {
    return $DownloadsTable(attachedDatabase, alias);
  }
}

class Download extends DataClass implements Insertable<Download> {
  final String id;
  final String songId;
  final String providerId;
  final String? path;
  final int status;
  final double progress;
  final DateTime createdAt;
  const Download(
      {required this.id,
      required this.songId,
      required this.providerId,
      this.path,
      required this.status,
      required this.progress,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['song_id'] = Variable<String>(songId);
    map['provider_id'] = Variable<String>(providerId);
    if (!nullToAbsent || path != null) {
      map['path'] = Variable<String>(path);
    }
    map['status'] = Variable<int>(status);
    map['progress'] = Variable<double>(progress);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DownloadsCompanion toCompanion(bool nullToAbsent) {
    return DownloadsCompanion(
      id: Value(id),
      songId: Value(songId),
      providerId: Value(providerId),
      path: path == null && nullToAbsent ? const Value.absent() : Value(path),
      status: Value(status),
      progress: Value(progress),
      createdAt: Value(createdAt),
    );
  }

  factory Download.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Download(
      id: serializer.fromJson<String>(json['id']),
      songId: serializer.fromJson<String>(json['songId']),
      providerId: serializer.fromJson<String>(json['providerId']),
      path: serializer.fromJson<String?>(json['path']),
      status: serializer.fromJson<int>(json['status']),
      progress: serializer.fromJson<double>(json['progress']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'songId': serializer.toJson<String>(songId),
      'providerId': serializer.toJson<String>(providerId),
      'path': serializer.toJson<String?>(path),
      'status': serializer.toJson<int>(status),
      'progress': serializer.toJson<double>(progress),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Download copyWith(
          {String? id,
          String? songId,
          String? providerId,
          Value<String?> path = const Value.absent(),
          int? status,
          double? progress,
          DateTime? createdAt}) =>
      Download(
        id: id ?? this.id,
        songId: songId ?? this.songId,
        providerId: providerId ?? this.providerId,
        path: path.present ? path.value : this.path,
        status: status ?? this.status,
        progress: progress ?? this.progress,
        createdAt: createdAt ?? this.createdAt,
      );
  Download copyWithCompanion(DownloadsCompanion data) {
    return Download(
      id: data.id.present ? data.id.value : this.id,
      songId: data.songId.present ? data.songId.value : this.songId,
      providerId:
          data.providerId.present ? data.providerId.value : this.providerId,
      path: data.path.present ? data.path.value : this.path,
      status: data.status.present ? data.status.value : this.status,
      progress: data.progress.present ? data.progress.value : this.progress,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Download(')
          ..write('id: $id, ')
          ..write('songId: $songId, ')
          ..write('providerId: $providerId, ')
          ..write('path: $path, ')
          ..write('status: $status, ')
          ..write('progress: $progress, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, songId, providerId, path, status, progress, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Download &&
          other.id == this.id &&
          other.songId == this.songId &&
          other.providerId == this.providerId &&
          other.path == this.path &&
          other.status == this.status &&
          other.progress == this.progress &&
          other.createdAt == this.createdAt);
}

class DownloadsCompanion extends UpdateCompanion<Download> {
  final Value<String> id;
  final Value<String> songId;
  final Value<String> providerId;
  final Value<String?> path;
  final Value<int> status;
  final Value<double> progress;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const DownloadsCompanion({
    this.id = const Value.absent(),
    this.songId = const Value.absent(),
    this.providerId = const Value.absent(),
    this.path = const Value.absent(),
    this.status = const Value.absent(),
    this.progress = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DownloadsCompanion.insert({
    required String id,
    required String songId,
    required String providerId,
    this.path = const Value.absent(),
    required int status,
    required double progress,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        songId = Value(songId),
        providerId = Value(providerId),
        status = Value(status),
        progress = Value(progress),
        createdAt = Value(createdAt);
  static Insertable<Download> custom({
    Expression<String>? id,
    Expression<String>? songId,
    Expression<String>? providerId,
    Expression<String>? path,
    Expression<int>? status,
    Expression<double>? progress,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (songId != null) 'song_id': songId,
      if (providerId != null) 'provider_id': providerId,
      if (path != null) 'path': path,
      if (status != null) 'status': status,
      if (progress != null) 'progress': progress,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DownloadsCompanion copyWith(
      {Value<String>? id,
      Value<String>? songId,
      Value<String>? providerId,
      Value<String?>? path,
      Value<int>? status,
      Value<double>? progress,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return DownloadsCompanion(
      id: id ?? this.id,
      songId: songId ?? this.songId,
      providerId: providerId ?? this.providerId,
      path: path ?? this.path,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (songId.present) {
      map['song_id'] = Variable<String>(songId.value);
    }
    if (providerId.present) {
      map['provider_id'] = Variable<String>(providerId.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (progress.present) {
      map['progress'] = Variable<double>(progress.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DownloadsCompanion(')
          ..write('id: $id, ')
          ..write('songId: $songId, ')
          ..write('providerId: $providerId, ')
          ..write('path: $path, ')
          ..write('status: $status, ')
          ..write('progress: $progress, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CloudSyncTable extends CloudSync
    with TableInfo<$CloudSyncTable, CloudSyncData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CloudSyncTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityTypeMeta =
      const VerificationMeta('entityType');
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
      'entity_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityIdMeta =
      const VerificationMeta('entityId');
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
      'entity_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _providerIdMeta =
      const VerificationMeta('providerId');
  @override
  late final GeneratedColumn<String> providerId = GeneratedColumn<String>(
      'provider_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _operationMeta =
      const VerificationMeta('operation');
  @override
  late final GeneratedColumn<int> operation = GeneratedColumn<int>(
      'operation', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _versionMeta =
      const VerificationMeta('version');
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
      'version', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _syncStateMeta =
      const VerificationMeta('syncState');
  @override
  late final GeneratedColumn<String> syncState = GeneratedColumn<String>(
      'sync_state', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        entityType,
        entityId,
        providerId,
        operation,
        version,
        syncState,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cloud_sync';
  @override
  VerificationContext validateIntegrity(Insertable<CloudSyncData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
          _entityTypeMeta,
          entityType.isAcceptableOrUnknown(
              data['entity_type']!, _entityTypeMeta));
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('provider_id')) {
      context.handle(
          _providerIdMeta,
          providerId.isAcceptableOrUnknown(
              data['provider_id']!, _providerIdMeta));
    } else if (isInserting) {
      context.missing(_providerIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(_operationMeta,
          operation.isAcceptableOrUnknown(data['operation']!, _operationMeta));
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('version')) {
      context.handle(_versionMeta,
          version.isAcceptableOrUnknown(data['version']!, _versionMeta));
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('sync_state')) {
      context.handle(_syncStateMeta,
          syncState.isAcceptableOrUnknown(data['sync_state']!, _syncStateMeta));
    } else if (isInserting) {
      context.missing(_syncStateMeta);
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
  CloudSyncData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CloudSyncData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      entityType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_type'])!,
      entityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_id'])!,
      providerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}provider_id'])!,
      operation: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}operation'])!,
      version: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}version'])!,
      syncState: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_state'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $CloudSyncTable createAlias(String alias) {
    return $CloudSyncTable(attachedDatabase, alias);
  }
}

class CloudSyncData extends DataClass implements Insertable<CloudSyncData> {
  final String id;
  final String entityType;
  final String entityId;
  final String providerId;
  final int operation;
  final int version;
  final String syncState;
  final DateTime updatedAt;
  const CloudSyncData(
      {required this.id,
      required this.entityType,
      required this.entityId,
      required this.providerId,
      required this.operation,
      required this.version,
      required this.syncState,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['provider_id'] = Variable<String>(providerId);
    map['operation'] = Variable<int>(operation);
    map['version'] = Variable<int>(version);
    map['sync_state'] = Variable<String>(syncState);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CloudSyncCompanion toCompanion(bool nullToAbsent) {
    return CloudSyncCompanion(
      id: Value(id),
      entityType: Value(entityType),
      entityId: Value(entityId),
      providerId: Value(providerId),
      operation: Value(operation),
      version: Value(version),
      syncState: Value(syncState),
      updatedAt: Value(updatedAt),
    );
  }

  factory CloudSyncData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CloudSyncData(
      id: serializer.fromJson<String>(json['id']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      providerId: serializer.fromJson<String>(json['providerId']),
      operation: serializer.fromJson<int>(json['operation']),
      version: serializer.fromJson<int>(json['version']),
      syncState: serializer.fromJson<String>(json['syncState']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'providerId': serializer.toJson<String>(providerId),
      'operation': serializer.toJson<int>(operation),
      'version': serializer.toJson<int>(version),
      'syncState': serializer.toJson<String>(syncState),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CloudSyncData copyWith(
          {String? id,
          String? entityType,
          String? entityId,
          String? providerId,
          int? operation,
          int? version,
          String? syncState,
          DateTime? updatedAt}) =>
      CloudSyncData(
        id: id ?? this.id,
        entityType: entityType ?? this.entityType,
        entityId: entityId ?? this.entityId,
        providerId: providerId ?? this.providerId,
        operation: operation ?? this.operation,
        version: version ?? this.version,
        syncState: syncState ?? this.syncState,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  CloudSyncData copyWithCompanion(CloudSyncCompanion data) {
    return CloudSyncData(
      id: data.id.present ? data.id.value : this.id,
      entityType:
          data.entityType.present ? data.entityType.value : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      providerId:
          data.providerId.present ? data.providerId.value : this.providerId,
      operation: data.operation.present ? data.operation.value : this.operation,
      version: data.version.present ? data.version.value : this.version,
      syncState: data.syncState.present ? data.syncState.value : this.syncState,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CloudSyncData(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('providerId: $providerId, ')
          ..write('operation: $operation, ')
          ..write('version: $version, ')
          ..write('syncState: $syncState, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, entityType, entityId, providerId,
      operation, version, syncState, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CloudSyncData &&
          other.id == this.id &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.providerId == this.providerId &&
          other.operation == this.operation &&
          other.version == this.version &&
          other.syncState == this.syncState &&
          other.updatedAt == this.updatedAt);
}

class CloudSyncCompanion extends UpdateCompanion<CloudSyncData> {
  final Value<String> id;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String> providerId;
  final Value<int> operation;
  final Value<int> version;
  final Value<String> syncState;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CloudSyncCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.providerId = const Value.absent(),
    this.operation = const Value.absent(),
    this.version = const Value.absent(),
    this.syncState = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CloudSyncCompanion.insert({
    required String id,
    required String entityType,
    required String entityId,
    required String providerId,
    required int operation,
    required int version,
    required String syncState,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        entityType = Value(entityType),
        entityId = Value(entityId),
        providerId = Value(providerId),
        operation = Value(operation),
        version = Value(version),
        syncState = Value(syncState),
        updatedAt = Value(updatedAt);
  static Insertable<CloudSyncData> custom({
    Expression<String>? id,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? providerId,
    Expression<int>? operation,
    Expression<int>? version,
    Expression<String>? syncState,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (providerId != null) 'provider_id': providerId,
      if (operation != null) 'operation': operation,
      if (version != null) 'version': version,
      if (syncState != null) 'sync_state': syncState,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CloudSyncCompanion copyWith(
      {Value<String>? id,
      Value<String>? entityType,
      Value<String>? entityId,
      Value<String>? providerId,
      Value<int>? operation,
      Value<int>? version,
      Value<String>? syncState,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return CloudSyncCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      providerId: providerId ?? this.providerId,
      operation: operation ?? this.operation,
      version: version ?? this.version,
      syncState: syncState ?? this.syncState,
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
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (providerId.present) {
      map['provider_id'] = Variable<String>(providerId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<int>(operation.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (syncState.present) {
      map['sync_state'] = Variable<String>(syncState.value);
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
    return (StringBuffer('CloudSyncCompanion(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('providerId: $providerId, ')
          ..write('operation: $operation, ')
          ..write('version: $version, ')
          ..write('syncState: $syncState, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StreamingCacheTable extends StreamingCache
    with TableInfo<$StreamingCacheTable, StreamingCacheData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StreamingCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _providerIdMeta =
      const VerificationMeta('providerId');
  @override
  late final GeneratedColumn<String> providerId = GeneratedColumn<String>(
      'provider_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<int> size = GeneratedColumn<int>(
      'size', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _lastAccessedAtMeta =
      const VerificationMeta('lastAccessedAt');
  @override
  late final GeneratedColumn<DateTime> lastAccessedAt =
      GeneratedColumn<DateTime>('last_accessed_at', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [key, providerId, path, size, lastAccessedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'streaming_cache';
  @override
  VerificationContext validateIntegrity(Insertable<StreamingCacheData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('provider_id')) {
      context.handle(
          _providerIdMeta,
          providerId.isAcceptableOrUnknown(
              data['provider_id']!, _providerIdMeta));
    } else if (isInserting) {
      context.missing(_providerIdMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('size')) {
      context.handle(
          _sizeMeta, size.isAcceptableOrUnknown(data['size']!, _sizeMeta));
    } else if (isInserting) {
      context.missing(_sizeMeta);
    }
    if (data.containsKey('last_accessed_at')) {
      context.handle(
          _lastAccessedAtMeta,
          lastAccessedAt.isAcceptableOrUnknown(
              data['last_accessed_at']!, _lastAccessedAtMeta));
    } else if (isInserting) {
      context.missing(_lastAccessedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  StreamingCacheData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StreamingCacheData(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      providerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}provider_id'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      size: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}size'])!,
      lastAccessedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_accessed_at'])!,
    );
  }

  @override
  $StreamingCacheTable createAlias(String alias) {
    return $StreamingCacheTable(attachedDatabase, alias);
  }
}

class StreamingCacheData extends DataClass
    implements Insertable<StreamingCacheData> {
  final String key;
  final String providerId;
  final String path;
  final int size;
  final DateTime lastAccessedAt;
  const StreamingCacheData(
      {required this.key,
      required this.providerId,
      required this.path,
      required this.size,
      required this.lastAccessedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['provider_id'] = Variable<String>(providerId);
    map['path'] = Variable<String>(path);
    map['size'] = Variable<int>(size);
    map['last_accessed_at'] = Variable<DateTime>(lastAccessedAt);
    return map;
  }

  StreamingCacheCompanion toCompanion(bool nullToAbsent) {
    return StreamingCacheCompanion(
      key: Value(key),
      providerId: Value(providerId),
      path: Value(path),
      size: Value(size),
      lastAccessedAt: Value(lastAccessedAt),
    );
  }

  factory StreamingCacheData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StreamingCacheData(
      key: serializer.fromJson<String>(json['key']),
      providerId: serializer.fromJson<String>(json['providerId']),
      path: serializer.fromJson<String>(json['path']),
      size: serializer.fromJson<int>(json['size']),
      lastAccessedAt: serializer.fromJson<DateTime>(json['lastAccessedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'providerId': serializer.toJson<String>(providerId),
      'path': serializer.toJson<String>(path),
      'size': serializer.toJson<int>(size),
      'lastAccessedAt': serializer.toJson<DateTime>(lastAccessedAt),
    };
  }

  StreamingCacheData copyWith(
          {String? key,
          String? providerId,
          String? path,
          int? size,
          DateTime? lastAccessedAt}) =>
      StreamingCacheData(
        key: key ?? this.key,
        providerId: providerId ?? this.providerId,
        path: path ?? this.path,
        size: size ?? this.size,
        lastAccessedAt: lastAccessedAt ?? this.lastAccessedAt,
      );
  StreamingCacheData copyWithCompanion(StreamingCacheCompanion data) {
    return StreamingCacheData(
      key: data.key.present ? data.key.value : this.key,
      providerId:
          data.providerId.present ? data.providerId.value : this.providerId,
      path: data.path.present ? data.path.value : this.path,
      size: data.size.present ? data.size.value : this.size,
      lastAccessedAt: data.lastAccessedAt.present
          ? data.lastAccessedAt.value
          : this.lastAccessedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StreamingCacheData(')
          ..write('key: $key, ')
          ..write('providerId: $providerId, ')
          ..write('path: $path, ')
          ..write('size: $size, ')
          ..write('lastAccessedAt: $lastAccessedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, providerId, path, size, lastAccessedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StreamingCacheData &&
          other.key == this.key &&
          other.providerId == this.providerId &&
          other.path == this.path &&
          other.size == this.size &&
          other.lastAccessedAt == this.lastAccessedAt);
}

class StreamingCacheCompanion extends UpdateCompanion<StreamingCacheData> {
  final Value<String> key;
  final Value<String> providerId;
  final Value<String> path;
  final Value<int> size;
  final Value<DateTime> lastAccessedAt;
  final Value<int> rowid;
  const StreamingCacheCompanion({
    this.key = const Value.absent(),
    this.providerId = const Value.absent(),
    this.path = const Value.absent(),
    this.size = const Value.absent(),
    this.lastAccessedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StreamingCacheCompanion.insert({
    required String key,
    required String providerId,
    required String path,
    required int size,
    required DateTime lastAccessedAt,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        providerId = Value(providerId),
        path = Value(path),
        size = Value(size),
        lastAccessedAt = Value(lastAccessedAt);
  static Insertable<StreamingCacheData> custom({
    Expression<String>? key,
    Expression<String>? providerId,
    Expression<String>? path,
    Expression<int>? size,
    Expression<DateTime>? lastAccessedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (providerId != null) 'provider_id': providerId,
      if (path != null) 'path': path,
      if (size != null) 'size': size,
      if (lastAccessedAt != null) 'last_accessed_at': lastAccessedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StreamingCacheCompanion copyWith(
      {Value<String>? key,
      Value<String>? providerId,
      Value<String>? path,
      Value<int>? size,
      Value<DateTime>? lastAccessedAt,
      Value<int>? rowid}) {
    return StreamingCacheCompanion(
      key: key ?? this.key,
      providerId: providerId ?? this.providerId,
      path: path ?? this.path,
      size: size ?? this.size,
      lastAccessedAt: lastAccessedAt ?? this.lastAccessedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (providerId.present) {
      map['provider_id'] = Variable<String>(providerId.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (size.present) {
      map['size'] = Variable<int>(size.value);
    }
    if (lastAccessedAt.present) {
      map['last_accessed_at'] = Variable<DateTime>(lastAccessedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StreamingCacheCompanion(')
          ..write('key: $key, ')
          ..write('providerId: $providerId, ')
          ..write('path: $path, ')
          ..write('size: $size, ')
          ..write('lastAccessedAt: $lastAccessedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LyricsCacheTable extends LyricsCache
    with TableInfo<$LyricsCacheTable, LyricsCacheData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LyricsCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _songIdMeta = const VerificationMeta('songId');
  @override
  late final GeneratedColumn<String> songId = GeneratedColumn<String>(
      'song_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _providerIdMeta =
      const VerificationMeta('providerId');
  @override
  late final GeneratedColumn<String> providerId = GeneratedColumn<String>(
      'provider_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isSyncedMeta =
      const VerificationMeta('isSynced');
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
      'is_synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [songId, providerId, content, isSynced, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lyrics_cache';
  @override
  VerificationContext validateIntegrity(Insertable<LyricsCacheData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('song_id')) {
      context.handle(_songIdMeta,
          songId.isAcceptableOrUnknown(data['song_id']!, _songIdMeta));
    } else if (isInserting) {
      context.missing(_songIdMeta);
    }
    if (data.containsKey('provider_id')) {
      context.handle(
          _providerIdMeta,
          providerId.isAcceptableOrUnknown(
              data['provider_id']!, _providerIdMeta));
    } else if (isInserting) {
      context.missing(_providerIdMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('is_synced')) {
      context.handle(_isSyncedMeta,
          isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta));
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
  Set<GeneratedColumn> get $primaryKey => {songId};
  @override
  LyricsCacheData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LyricsCacheData(
      songId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}song_id'])!,
      providerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}provider_id'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      isSynced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synced'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $LyricsCacheTable createAlias(String alias) {
    return $LyricsCacheTable(attachedDatabase, alias);
  }
}

class LyricsCacheData extends DataClass implements Insertable<LyricsCacheData> {
  final String songId;
  final String providerId;
  final String content;
  final bool isSynced;
  final DateTime updatedAt;
  const LyricsCacheData(
      {required this.songId,
      required this.providerId,
      required this.content,
      required this.isSynced,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['song_id'] = Variable<String>(songId);
    map['provider_id'] = Variable<String>(providerId);
    map['content'] = Variable<String>(content);
    map['is_synced'] = Variable<bool>(isSynced);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LyricsCacheCompanion toCompanion(bool nullToAbsent) {
    return LyricsCacheCompanion(
      songId: Value(songId),
      providerId: Value(providerId),
      content: Value(content),
      isSynced: Value(isSynced),
      updatedAt: Value(updatedAt),
    );
  }

  factory LyricsCacheData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LyricsCacheData(
      songId: serializer.fromJson<String>(json['songId']),
      providerId: serializer.fromJson<String>(json['providerId']),
      content: serializer.fromJson<String>(json['content']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'songId': serializer.toJson<String>(songId),
      'providerId': serializer.toJson<String>(providerId),
      'content': serializer.toJson<String>(content),
      'isSynced': serializer.toJson<bool>(isSynced),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LyricsCacheData copyWith(
          {String? songId,
          String? providerId,
          String? content,
          bool? isSynced,
          DateTime? updatedAt}) =>
      LyricsCacheData(
        songId: songId ?? this.songId,
        providerId: providerId ?? this.providerId,
        content: content ?? this.content,
        isSynced: isSynced ?? this.isSynced,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  LyricsCacheData copyWithCompanion(LyricsCacheCompanion data) {
    return LyricsCacheData(
      songId: data.songId.present ? data.songId.value : this.songId,
      providerId:
          data.providerId.present ? data.providerId.value : this.providerId,
      content: data.content.present ? data.content.value : this.content,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LyricsCacheData(')
          ..write('songId: $songId, ')
          ..write('providerId: $providerId, ')
          ..write('content: $content, ')
          ..write('isSynced: $isSynced, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(songId, providerId, content, isSynced, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LyricsCacheData &&
          other.songId == this.songId &&
          other.providerId == this.providerId &&
          other.content == this.content &&
          other.isSynced == this.isSynced &&
          other.updatedAt == this.updatedAt);
}

class LyricsCacheCompanion extends UpdateCompanion<LyricsCacheData> {
  final Value<String> songId;
  final Value<String> providerId;
  final Value<String> content;
  final Value<bool> isSynced;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const LyricsCacheCompanion({
    this.songId = const Value.absent(),
    this.providerId = const Value.absent(),
    this.content = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LyricsCacheCompanion.insert({
    required String songId,
    required String providerId,
    required String content,
    this.isSynced = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : songId = Value(songId),
        providerId = Value(providerId),
        content = Value(content),
        updatedAt = Value(updatedAt);
  static Insertable<LyricsCacheData> custom({
    Expression<String>? songId,
    Expression<String>? providerId,
    Expression<String>? content,
    Expression<bool>? isSynced,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (songId != null) 'song_id': songId,
      if (providerId != null) 'provider_id': providerId,
      if (content != null) 'content': content,
      if (isSynced != null) 'is_synced': isSynced,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LyricsCacheCompanion copyWith(
      {Value<String>? songId,
      Value<String>? providerId,
      Value<String>? content,
      Value<bool>? isSynced,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return LyricsCacheCompanion(
      songId: songId ?? this.songId,
      providerId: providerId ?? this.providerId,
      content: content ?? this.content,
      isSynced: isSynced ?? this.isSynced,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (songId.present) {
      map['song_id'] = Variable<String>(songId.value);
    }
    if (providerId.present) {
      map['provider_id'] = Variable<String>(providerId.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
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
    return (StringBuffer('LyricsCacheCompanion(')
          ..write('songId: $songId, ')
          ..write('providerId: $providerId, ')
          ..write('content: $content, ')
          ..write('isSynced: $isSynced, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AuthenticationTable extends Authentication
    with TableInfo<$AuthenticationTable, AuthenticationData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuthenticationTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _providerIdMeta =
      const VerificationMeta('providerId');
  @override
  late final GeneratedColumn<String> providerId = GeneratedColumn<String>(
      'provider_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isLoggedInMeta =
      const VerificationMeta('isLoggedIn');
  @override
  late final GeneratedColumn<bool> isLoggedIn = GeneratedColumn<bool>(
      'is_logged_in', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_logged_in" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _displayNameMeta =
      const VerificationMeta('displayName');
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
      'display_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _avatarUrlMeta =
      const VerificationMeta('avatarUrl');
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
      'avatar_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [providerId, userId, isLoggedIn, displayName, avatarUrl];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'authentication';
  @override
  VerificationContext validateIntegrity(Insertable<AuthenticationData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('provider_id')) {
      context.handle(
          _providerIdMeta,
          providerId.isAcceptableOrUnknown(
              data['provider_id']!, _providerIdMeta));
    } else if (isInserting) {
      context.missing(_providerIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('is_logged_in')) {
      context.handle(
          _isLoggedInMeta,
          isLoggedIn.isAcceptableOrUnknown(
              data['is_logged_in']!, _isLoggedInMeta));
    }
    if (data.containsKey('display_name')) {
      context.handle(
          _displayNameMeta,
          displayName.isAcceptableOrUnknown(
              data['display_name']!, _displayNameMeta));
    }
    if (data.containsKey('avatar_url')) {
      context.handle(_avatarUrlMeta,
          avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {providerId, userId};
  @override
  AuthenticationData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuthenticationData(
      providerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}provider_id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      isLoggedIn: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_logged_in'])!,
      displayName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}display_name']),
      avatarUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}avatar_url']),
    );
  }

  @override
  $AuthenticationTable createAlias(String alias) {
    return $AuthenticationTable(attachedDatabase, alias);
  }
}

class AuthenticationData extends DataClass
    implements Insertable<AuthenticationData> {
  final String providerId;
  final String userId;
  final bool isLoggedIn;
  final String? displayName;
  final String? avatarUrl;
  const AuthenticationData(
      {required this.providerId,
      required this.userId,
      required this.isLoggedIn,
      this.displayName,
      this.avatarUrl});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['provider_id'] = Variable<String>(providerId);
    map['user_id'] = Variable<String>(userId);
    map['is_logged_in'] = Variable<bool>(isLoggedIn);
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    return map;
  }

  AuthenticationCompanion toCompanion(bool nullToAbsent) {
    return AuthenticationCompanion(
      providerId: Value(providerId),
      userId: Value(userId),
      isLoggedIn: Value(isLoggedIn),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
    );
  }

  factory AuthenticationData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuthenticationData(
      providerId: serializer.fromJson<String>(json['providerId']),
      userId: serializer.fromJson<String>(json['userId']),
      isLoggedIn: serializer.fromJson<bool>(json['isLoggedIn']),
      displayName: serializer.fromJson<String?>(json['displayName']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'providerId': serializer.toJson<String>(providerId),
      'userId': serializer.toJson<String>(userId),
      'isLoggedIn': serializer.toJson<bool>(isLoggedIn),
      'displayName': serializer.toJson<String?>(displayName),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
    };
  }

  AuthenticationData copyWith(
          {String? providerId,
          String? userId,
          bool? isLoggedIn,
          Value<String?> displayName = const Value.absent(),
          Value<String?> avatarUrl = const Value.absent()}) =>
      AuthenticationData(
        providerId: providerId ?? this.providerId,
        userId: userId ?? this.userId,
        isLoggedIn: isLoggedIn ?? this.isLoggedIn,
        displayName: displayName.present ? displayName.value : this.displayName,
        avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
      );
  AuthenticationData copyWithCompanion(AuthenticationCompanion data) {
    return AuthenticationData(
      providerId:
          data.providerId.present ? data.providerId.value : this.providerId,
      userId: data.userId.present ? data.userId.value : this.userId,
      isLoggedIn:
          data.isLoggedIn.present ? data.isLoggedIn.value : this.isLoggedIn,
      displayName:
          data.displayName.present ? data.displayName.value : this.displayName,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuthenticationData(')
          ..write('providerId: $providerId, ')
          ..write('userId: $userId, ')
          ..write('isLoggedIn: $isLoggedIn, ')
          ..write('displayName: $displayName, ')
          ..write('avatarUrl: $avatarUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(providerId, userId, isLoggedIn, displayName, avatarUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuthenticationData &&
          other.providerId == this.providerId &&
          other.userId == this.userId &&
          other.isLoggedIn == this.isLoggedIn &&
          other.displayName == this.displayName &&
          other.avatarUrl == this.avatarUrl);
}

class AuthenticationCompanion extends UpdateCompanion<AuthenticationData> {
  final Value<String> providerId;
  final Value<String> userId;
  final Value<bool> isLoggedIn;
  final Value<String?> displayName;
  final Value<String?> avatarUrl;
  final Value<int> rowid;
  const AuthenticationCompanion({
    this.providerId = const Value.absent(),
    this.userId = const Value.absent(),
    this.isLoggedIn = const Value.absent(),
    this.displayName = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AuthenticationCompanion.insert({
    required String providerId,
    required String userId,
    this.isLoggedIn = const Value.absent(),
    this.displayName = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : providerId = Value(providerId),
        userId = Value(userId);
  static Insertable<AuthenticationData> custom({
    Expression<String>? providerId,
    Expression<String>? userId,
    Expression<bool>? isLoggedIn,
    Expression<String>? displayName,
    Expression<String>? avatarUrl,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (providerId != null) 'provider_id': providerId,
      if (userId != null) 'user_id': userId,
      if (isLoggedIn != null) 'is_logged_in': isLoggedIn,
      if (displayName != null) 'display_name': displayName,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AuthenticationCompanion copyWith(
      {Value<String>? providerId,
      Value<String>? userId,
      Value<bool>? isLoggedIn,
      Value<String?>? displayName,
      Value<String?>? avatarUrl,
      Value<int>? rowid}) {
    return AuthenticationCompanion(
      providerId: providerId ?? this.providerId,
      userId: userId ?? this.userId,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (providerId.present) {
      map['provider_id'] = Variable<String>(providerId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (isLoggedIn.present) {
      map['is_logged_in'] = Variable<bool>(isLoggedIn.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuthenticationCompanion(')
          ..write('providerId: $providerId, ')
          ..write('userId: $userId, ')
          ..write('isLoggedIn: $isLoggedIn, ')
          ..write('displayName: $displayName, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProviderSettingsTable extends ProviderSettings
    with TableInfo<$ProviderSettingsTable, ProviderSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProviderSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _enabledMeta =
      const VerificationMeta('enabled');
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
      'enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
      'priority', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _healthStatusMeta =
      const VerificationMeta('healthStatus');
  @override
  late final GeneratedColumn<String> healthStatus = GeneratedColumn<String>(
      'health_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('healthy'));
  @override
  List<GeneratedColumn> get $columns => [id, enabled, priority, healthStatus];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'provider_settings';
  @override
  VerificationContext validateIntegrity(Insertable<ProviderSetting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('enabled')) {
      context.handle(_enabledMeta,
          enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta));
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    }
    if (data.containsKey('health_status')) {
      context.handle(
          _healthStatusMeta,
          healthStatus.isAcceptableOrUnknown(
              data['health_status']!, _healthStatusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProviderSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProviderSetting(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      enabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}enabled'])!,
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}priority'])!,
      healthStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}health_status'])!,
    );
  }

  @override
  $ProviderSettingsTable createAlias(String alias) {
    return $ProviderSettingsTable(attachedDatabase, alias);
  }
}

class ProviderSetting extends DataClass implements Insertable<ProviderSetting> {
  final String id;
  final bool enabled;
  final int priority;
  final String healthStatus;
  const ProviderSetting(
      {required this.id,
      required this.enabled,
      required this.priority,
      required this.healthStatus});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['enabled'] = Variable<bool>(enabled);
    map['priority'] = Variable<int>(priority);
    map['health_status'] = Variable<String>(healthStatus);
    return map;
  }

  ProviderSettingsCompanion toCompanion(bool nullToAbsent) {
    return ProviderSettingsCompanion(
      id: Value(id),
      enabled: Value(enabled),
      priority: Value(priority),
      healthStatus: Value(healthStatus),
    );
  }

  factory ProviderSetting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProviderSetting(
      id: serializer.fromJson<String>(json['id']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      priority: serializer.fromJson<int>(json['priority']),
      healthStatus: serializer.fromJson<String>(json['healthStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'enabled': serializer.toJson<bool>(enabled),
      'priority': serializer.toJson<int>(priority),
      'healthStatus': serializer.toJson<String>(healthStatus),
    };
  }

  ProviderSetting copyWith(
          {String? id, bool? enabled, int? priority, String? healthStatus}) =>
      ProviderSetting(
        id: id ?? this.id,
        enabled: enabled ?? this.enabled,
        priority: priority ?? this.priority,
        healthStatus: healthStatus ?? this.healthStatus,
      );
  ProviderSetting copyWithCompanion(ProviderSettingsCompanion data) {
    return ProviderSetting(
      id: data.id.present ? data.id.value : this.id,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      priority: data.priority.present ? data.priority.value : this.priority,
      healthStatus: data.healthStatus.present
          ? data.healthStatus.value
          : this.healthStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProviderSetting(')
          ..write('id: $id, ')
          ..write('enabled: $enabled, ')
          ..write('priority: $priority, ')
          ..write('healthStatus: $healthStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, enabled, priority, healthStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProviderSetting &&
          other.id == this.id &&
          other.enabled == this.enabled &&
          other.priority == this.priority &&
          other.healthStatus == this.healthStatus);
}

class ProviderSettingsCompanion extends UpdateCompanion<ProviderSetting> {
  final Value<String> id;
  final Value<bool> enabled;
  final Value<int> priority;
  final Value<String> healthStatus;
  final Value<int> rowid;
  const ProviderSettingsCompanion({
    this.id = const Value.absent(),
    this.enabled = const Value.absent(),
    this.priority = const Value.absent(),
    this.healthStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProviderSettingsCompanion.insert({
    required String id,
    this.enabled = const Value.absent(),
    this.priority = const Value.absent(),
    this.healthStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<ProviderSetting> custom({
    Expression<String>? id,
    Expression<bool>? enabled,
    Expression<int>? priority,
    Expression<String>? healthStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (enabled != null) 'enabled': enabled,
      if (priority != null) 'priority': priority,
      if (healthStatus != null) 'health_status': healthStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProviderSettingsCompanion copyWith(
      {Value<String>? id,
      Value<bool>? enabled,
      Value<int>? priority,
      Value<String>? healthStatus,
      Value<int>? rowid}) {
    return ProviderSettingsCompanion(
      id: id ?? this.id,
      enabled: enabled ?? this.enabled,
      priority: priority ?? this.priority,
      healthStatus: healthStatus ?? this.healthStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (healthStatus.present) {
      map['health_status'] = Variable<String>(healthStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProviderSettingsCompanion(')
          ..write('id: $id, ')
          ..write('enabled: $enabled, ')
          ..write('priority: $priority, ')
          ..write('healthStatus: $healthStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTable extends SyncQueue
    with TableInfo<$SyncQueueTable, SyncQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _syncTableNameMeta =
      const VerificationMeta('syncTableName');
  @override
  late final GeneratedColumn<String> syncTableName = GeneratedColumn<String>(
      'sync_table_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _recordIdMeta =
      const VerificationMeta('recordId');
  @override
  late final GeneratedColumn<String> recordId = GeneratedColumn<String>(
      'record_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _operationMeta =
      const VerificationMeta('operation');
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
      'operation', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payloadMeta =
      const VerificationMeta('payload');
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
      'payload', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _retriesMeta =
      const VerificationMeta('retries');
  @override
  late final GeneratedColumn<int> retries = GeneratedColumn<int>(
      'retries', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, syncTableName, recordId, operation, payload, retries];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(Insertable<SyncQueueData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sync_table_name')) {
      context.handle(
          _syncTableNameMeta,
          syncTableName.isAcceptableOrUnknown(
              data['sync_table_name']!, _syncTableNameMeta));
    } else if (isInserting) {
      context.missing(_syncTableNameMeta);
    }
    if (data.containsKey('record_id')) {
      context.handle(_recordIdMeta,
          recordId.isAcceptableOrUnknown(data['record_id']!, _recordIdMeta));
    } else if (isInserting) {
      context.missing(_recordIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(_operationMeta,
          operation.isAcceptableOrUnknown(data['operation']!, _operationMeta));
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(_payloadMeta,
          payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta));
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('retries')) {
      context.handle(_retriesMeta,
          retries.isAcceptableOrUnknown(data['retries']!, _retriesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      syncTableName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}sync_table_name'])!,
      recordId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}record_id'])!,
      operation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}operation'])!,
      payload: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload'])!,
      retries: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}retries'])!,
    );
  }

  @override
  $SyncQueueTable createAlias(String alias) {
    return $SyncQueueTable(attachedDatabase, alias);
  }
}

class SyncQueueData extends DataClass implements Insertable<SyncQueueData> {
  final int id;
  final String syncTableName;
  final String recordId;
  final String operation;
  final String payload;
  final int retries;
  const SyncQueueData(
      {required this.id,
      required this.syncTableName,
      required this.recordId,
      required this.operation,
      required this.payload,
      required this.retries});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sync_table_name'] = Variable<String>(syncTableName);
    map['record_id'] = Variable<String>(recordId);
    map['operation'] = Variable<String>(operation);
    map['payload'] = Variable<String>(payload);
    map['retries'] = Variable<int>(retries);
    return map;
  }

  SyncQueueCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueCompanion(
      id: Value(id),
      syncTableName: Value(syncTableName),
      recordId: Value(recordId),
      operation: Value(operation),
      payload: Value(payload),
      retries: Value(retries),
    );
  }

  factory SyncQueueData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueData(
      id: serializer.fromJson<int>(json['id']),
      syncTableName: serializer.fromJson<String>(json['syncTableName']),
      recordId: serializer.fromJson<String>(json['recordId']),
      operation: serializer.fromJson<String>(json['operation']),
      payload: serializer.fromJson<String>(json['payload']),
      retries: serializer.fromJson<int>(json['retries']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'syncTableName': serializer.toJson<String>(syncTableName),
      'recordId': serializer.toJson<String>(recordId),
      'operation': serializer.toJson<String>(operation),
      'payload': serializer.toJson<String>(payload),
      'retries': serializer.toJson<int>(retries),
    };
  }

  SyncQueueData copyWith(
          {int? id,
          String? syncTableName,
          String? recordId,
          String? operation,
          String? payload,
          int? retries}) =>
      SyncQueueData(
        id: id ?? this.id,
        syncTableName: syncTableName ?? this.syncTableName,
        recordId: recordId ?? this.recordId,
        operation: operation ?? this.operation,
        payload: payload ?? this.payload,
        retries: retries ?? this.retries,
      );
  SyncQueueData copyWithCompanion(SyncQueueCompanion data) {
    return SyncQueueData(
      id: data.id.present ? data.id.value : this.id,
      syncTableName: data.syncTableName.present
          ? data.syncTableName.value
          : this.syncTableName,
      recordId: data.recordId.present ? data.recordId.value : this.recordId,
      operation: data.operation.present ? data.operation.value : this.operation,
      payload: data.payload.present ? data.payload.value : this.payload,
      retries: data.retries.present ? data.retries.value : this.retries,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueData(')
          ..write('id: $id, ')
          ..write('syncTableName: $syncTableName, ')
          ..write('recordId: $recordId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('retries: $retries')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, syncTableName, recordId, operation, payload, retries);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueData &&
          other.id == this.id &&
          other.syncTableName == this.syncTableName &&
          other.recordId == this.recordId &&
          other.operation == this.operation &&
          other.payload == this.payload &&
          other.retries == this.retries);
}

class SyncQueueCompanion extends UpdateCompanion<SyncQueueData> {
  final Value<int> id;
  final Value<String> syncTableName;
  final Value<String> recordId;
  final Value<String> operation;
  final Value<String> payload;
  final Value<int> retries;
  const SyncQueueCompanion({
    this.id = const Value.absent(),
    this.syncTableName = const Value.absent(),
    this.recordId = const Value.absent(),
    this.operation = const Value.absent(),
    this.payload = const Value.absent(),
    this.retries = const Value.absent(),
  });
  SyncQueueCompanion.insert({
    this.id = const Value.absent(),
    required String syncTableName,
    required String recordId,
    required String operation,
    required String payload,
    this.retries = const Value.absent(),
  })  : syncTableName = Value(syncTableName),
        recordId = Value(recordId),
        operation = Value(operation),
        payload = Value(payload);
  static Insertable<SyncQueueData> custom({
    Expression<int>? id,
    Expression<String>? syncTableName,
    Expression<String>? recordId,
    Expression<String>? operation,
    Expression<String>? payload,
    Expression<int>? retries,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncTableName != null) 'sync_table_name': syncTableName,
      if (recordId != null) 'record_id': recordId,
      if (operation != null) 'operation': operation,
      if (payload != null) 'payload': payload,
      if (retries != null) 'retries': retries,
    });
  }

  SyncQueueCompanion copyWith(
      {Value<int>? id,
      Value<String>? syncTableName,
      Value<String>? recordId,
      Value<String>? operation,
      Value<String>? payload,
      Value<int>? retries}) {
    return SyncQueueCompanion(
      id: id ?? this.id,
      syncTableName: syncTableName ?? this.syncTableName,
      recordId: recordId ?? this.recordId,
      operation: operation ?? this.operation,
      payload: payload ?? this.payload,
      retries: retries ?? this.retries,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (syncTableName.present) {
      map['sync_table_name'] = Variable<String>(syncTableName.value);
    }
    if (recordId.present) {
      map['record_id'] = Variable<String>(recordId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (retries.present) {
      map['retries'] = Variable<int>(retries.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueCompanion(')
          ..write('id: $id, ')
          ..write('syncTableName: $syncTableName, ')
          ..write('recordId: $recordId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('retries: $retries')
          ..write(')'))
        .toString();
  }
}

class $MediaQualityTable extends MediaQuality
    with TableInfo<$MediaQualityTable, MediaQualityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MediaQualityTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'media_quality';
  @override
  VerificationContext validateIntegrity(Insertable<MediaQualityData> instance,
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
  MediaQualityData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MediaQualityData(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $MediaQualityTable createAlias(String alias) {
    return $MediaQualityTable(attachedDatabase, alias);
  }
}

class MediaQualityData extends DataClass
    implements Insertable<MediaQualityData> {
  final String key;
  final String value;
  const MediaQualityData({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  MediaQualityCompanion toCompanion(bool nullToAbsent) {
    return MediaQualityCompanion(
      key: Value(key),
      value: Value(value),
    );
  }

  factory MediaQualityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MediaQualityData(
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

  MediaQualityData copyWith({String? key, String? value}) => MediaQualityData(
        key: key ?? this.key,
        value: value ?? this.value,
      );
  MediaQualityData copyWithCompanion(MediaQualityCompanion data) {
    return MediaQualityData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MediaQualityData(')
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
      (other is MediaQualityData &&
          other.key == this.key &&
          other.value == this.value);
}

class MediaQualityCompanion extends UpdateCompanion<MediaQualityData> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const MediaQualityCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MediaQualityCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value);
  static Insertable<MediaQualityData> custom({
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

  MediaQualityCompanion copyWith(
      {Value<String>? key, Value<String>? value, Value<int>? rowid}) {
    return MediaQualityCompanion(
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
    return (StringBuffer('MediaQualityCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlaybackStatisticsTable extends PlaybackStatistics
    with TableInfo<$PlaybackStatisticsTable, PlaybackStatistic> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaybackStatisticsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _songIdMeta = const VerificationMeta('songId');
  @override
  late final GeneratedColumn<String> songId = GeneratedColumn<String>(
      'song_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _playCountMeta =
      const VerificationMeta('playCount');
  @override
  late final GeneratedColumn<int> playCount = GeneratedColumn<int>(
      'play_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _skipCountMeta =
      const VerificationMeta('skipCount');
  @override
  late final GeneratedColumn<int> skipCount = GeneratedColumn<int>(
      'skip_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _completionRateMeta =
      const VerificationMeta('completionRate');
  @override
  late final GeneratedColumn<double> completionRate = GeneratedColumn<double>(
      'completion_rate', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _lastPlayedAtMeta =
      const VerificationMeta('lastPlayedAt');
  @override
  late final GeneratedColumn<DateTime> lastPlayedAt = GeneratedColumn<DateTime>(
      'last_played_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [songId, playCount, skipCount, completionRate, lastPlayedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'playback_statistics';
  @override
  VerificationContext validateIntegrity(Insertable<PlaybackStatistic> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('song_id')) {
      context.handle(_songIdMeta,
          songId.isAcceptableOrUnknown(data['song_id']!, _songIdMeta));
    } else if (isInserting) {
      context.missing(_songIdMeta);
    }
    if (data.containsKey('play_count')) {
      context.handle(_playCountMeta,
          playCount.isAcceptableOrUnknown(data['play_count']!, _playCountMeta));
    }
    if (data.containsKey('skip_count')) {
      context.handle(_skipCountMeta,
          skipCount.isAcceptableOrUnknown(data['skip_count']!, _skipCountMeta));
    }
    if (data.containsKey('completion_rate')) {
      context.handle(
          _completionRateMeta,
          completionRate.isAcceptableOrUnknown(
              data['completion_rate']!, _completionRateMeta));
    }
    if (data.containsKey('last_played_at')) {
      context.handle(
          _lastPlayedAtMeta,
          lastPlayedAt.isAcceptableOrUnknown(
              data['last_played_at']!, _lastPlayedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {songId};
  @override
  PlaybackStatistic map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaybackStatistic(
      songId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}song_id'])!,
      playCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}play_count'])!,
      skipCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}skip_count'])!,
      completionRate: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}completion_rate'])!,
      lastPlayedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_played_at']),
    );
  }

  @override
  $PlaybackStatisticsTable createAlias(String alias) {
    return $PlaybackStatisticsTable(attachedDatabase, alias);
  }
}

class PlaybackStatistic extends DataClass
    implements Insertable<PlaybackStatistic> {
  final String songId;
  final int playCount;
  final int skipCount;
  final double completionRate;
  final DateTime? lastPlayedAt;
  const PlaybackStatistic(
      {required this.songId,
      required this.playCount,
      required this.skipCount,
      required this.completionRate,
      this.lastPlayedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['song_id'] = Variable<String>(songId);
    map['play_count'] = Variable<int>(playCount);
    map['skip_count'] = Variable<int>(skipCount);
    map['completion_rate'] = Variable<double>(completionRate);
    if (!nullToAbsent || lastPlayedAt != null) {
      map['last_played_at'] = Variable<DateTime>(lastPlayedAt);
    }
    return map;
  }

  PlaybackStatisticsCompanion toCompanion(bool nullToAbsent) {
    return PlaybackStatisticsCompanion(
      songId: Value(songId),
      playCount: Value(playCount),
      skipCount: Value(skipCount),
      completionRate: Value(completionRate),
      lastPlayedAt: lastPlayedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPlayedAt),
    );
  }

  factory PlaybackStatistic.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaybackStatistic(
      songId: serializer.fromJson<String>(json['songId']),
      playCount: serializer.fromJson<int>(json['playCount']),
      skipCount: serializer.fromJson<int>(json['skipCount']),
      completionRate: serializer.fromJson<double>(json['completionRate']),
      lastPlayedAt: serializer.fromJson<DateTime?>(json['lastPlayedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'songId': serializer.toJson<String>(songId),
      'playCount': serializer.toJson<int>(playCount),
      'skipCount': serializer.toJson<int>(skipCount),
      'completionRate': serializer.toJson<double>(completionRate),
      'lastPlayedAt': serializer.toJson<DateTime?>(lastPlayedAt),
    };
  }

  PlaybackStatistic copyWith(
          {String? songId,
          int? playCount,
          int? skipCount,
          double? completionRate,
          Value<DateTime?> lastPlayedAt = const Value.absent()}) =>
      PlaybackStatistic(
        songId: songId ?? this.songId,
        playCount: playCount ?? this.playCount,
        skipCount: skipCount ?? this.skipCount,
        completionRate: completionRate ?? this.completionRate,
        lastPlayedAt:
            lastPlayedAt.present ? lastPlayedAt.value : this.lastPlayedAt,
      );
  PlaybackStatistic copyWithCompanion(PlaybackStatisticsCompanion data) {
    return PlaybackStatistic(
      songId: data.songId.present ? data.songId.value : this.songId,
      playCount: data.playCount.present ? data.playCount.value : this.playCount,
      skipCount: data.skipCount.present ? data.skipCount.value : this.skipCount,
      completionRate: data.completionRate.present
          ? data.completionRate.value
          : this.completionRate,
      lastPlayedAt: data.lastPlayedAt.present
          ? data.lastPlayedAt.value
          : this.lastPlayedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlaybackStatistic(')
          ..write('songId: $songId, ')
          ..write('playCount: $playCount, ')
          ..write('skipCount: $skipCount, ')
          ..write('completionRate: $completionRate, ')
          ..write('lastPlayedAt: $lastPlayedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(songId, playCount, skipCount, completionRate, lastPlayedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaybackStatistic &&
          other.songId == this.songId &&
          other.playCount == this.playCount &&
          other.skipCount == this.skipCount &&
          other.completionRate == this.completionRate &&
          other.lastPlayedAt == this.lastPlayedAt);
}

class PlaybackStatisticsCompanion extends UpdateCompanion<PlaybackStatistic> {
  final Value<String> songId;
  final Value<int> playCount;
  final Value<int> skipCount;
  final Value<double> completionRate;
  final Value<DateTime?> lastPlayedAt;
  final Value<int> rowid;
  const PlaybackStatisticsCompanion({
    this.songId = const Value.absent(),
    this.playCount = const Value.absent(),
    this.skipCount = const Value.absent(),
    this.completionRate = const Value.absent(),
    this.lastPlayedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlaybackStatisticsCompanion.insert({
    required String songId,
    this.playCount = const Value.absent(),
    this.skipCount = const Value.absent(),
    this.completionRate = const Value.absent(),
    this.lastPlayedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : songId = Value(songId);
  static Insertable<PlaybackStatistic> custom({
    Expression<String>? songId,
    Expression<int>? playCount,
    Expression<int>? skipCount,
    Expression<double>? completionRate,
    Expression<DateTime>? lastPlayedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (songId != null) 'song_id': songId,
      if (playCount != null) 'play_count': playCount,
      if (skipCount != null) 'skip_count': skipCount,
      if (completionRate != null) 'completion_rate': completionRate,
      if (lastPlayedAt != null) 'last_played_at': lastPlayedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlaybackStatisticsCompanion copyWith(
      {Value<String>? songId,
      Value<int>? playCount,
      Value<int>? skipCount,
      Value<double>? completionRate,
      Value<DateTime?>? lastPlayedAt,
      Value<int>? rowid}) {
    return PlaybackStatisticsCompanion(
      songId: songId ?? this.songId,
      playCount: playCount ?? this.playCount,
      skipCount: skipCount ?? this.skipCount,
      completionRate: completionRate ?? this.completionRate,
      lastPlayedAt: lastPlayedAt ?? this.lastPlayedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (songId.present) {
      map['song_id'] = Variable<String>(songId.value);
    }
    if (playCount.present) {
      map['play_count'] = Variable<int>(playCount.value);
    }
    if (skipCount.present) {
      map['skip_count'] = Variable<int>(skipCount.value);
    }
    if (completionRate.present) {
      map['completion_rate'] = Variable<double>(completionRate.value);
    }
    if (lastPlayedAt.present) {
      map['last_played_at'] = Variable<DateTime>(lastPlayedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaybackStatisticsCompanion(')
          ..write('songId: $songId, ')
          ..write('playCount: $playCount, ')
          ..write('skipCount: $skipCount, ')
          ..write('completionRate: $completionRate, ')
          ..write('lastPlayedAt: $lastPlayedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ListeningSessionsTable extends ListeningSessions
    with TableInfo<$ListeningSessionsTable, ListeningSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ListeningSessionsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _durationSecondsMeta =
      const VerificationMeta('durationSeconds');
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
      'duration_seconds', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _completedMeta =
      const VerificationMeta('completed');
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
      'completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _timeOfDayMeta =
      const VerificationMeta('timeOfDay');
  @override
  late final GeneratedColumn<String> timeOfDay = GeneratedColumn<String>(
      'time_of_day', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dayOfWeekMeta =
      const VerificationMeta('dayOfWeek');
  @override
  late final GeneratedColumn<int> dayOfWeek = GeneratedColumn<int>(
      'day_of_week', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, songId, playedAt, durationSeconds, completed, timeOfDay, dayOfWeek];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'listening_sessions';
  @override
  VerificationContext validateIntegrity(Insertable<ListeningSession> instance,
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
    if (data.containsKey('duration_seconds')) {
      context.handle(
          _durationSecondsMeta,
          durationSeconds.isAcceptableOrUnknown(
              data['duration_seconds']!, _durationSecondsMeta));
    } else if (isInserting) {
      context.missing(_durationSecondsMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed']!, _completedMeta));
    }
    if (data.containsKey('time_of_day')) {
      context.handle(
          _timeOfDayMeta,
          timeOfDay.isAcceptableOrUnknown(
              data['time_of_day']!, _timeOfDayMeta));
    } else if (isInserting) {
      context.missing(_timeOfDayMeta);
    }
    if (data.containsKey('day_of_week')) {
      context.handle(
          _dayOfWeekMeta,
          dayOfWeek.isAcceptableOrUnknown(
              data['day_of_week']!, _dayOfWeekMeta));
    } else if (isInserting) {
      context.missing(_dayOfWeekMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ListeningSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ListeningSession(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      songId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}song_id'])!,
      playedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}played_at'])!,
      durationSeconds: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_seconds'])!,
      completed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}completed'])!,
      timeOfDay: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}time_of_day'])!,
      dayOfWeek: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}day_of_week'])!,
    );
  }

  @override
  $ListeningSessionsTable createAlias(String alias) {
    return $ListeningSessionsTable(attachedDatabase, alias);
  }
}

class ListeningSession extends DataClass
    implements Insertable<ListeningSession> {
  final int id;
  final String songId;
  final DateTime playedAt;
  final int durationSeconds;
  final bool completed;
  final String timeOfDay;
  final int dayOfWeek;
  const ListeningSession(
      {required this.id,
      required this.songId,
      required this.playedAt,
      required this.durationSeconds,
      required this.completed,
      required this.timeOfDay,
      required this.dayOfWeek});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['song_id'] = Variable<String>(songId);
    map['played_at'] = Variable<DateTime>(playedAt);
    map['duration_seconds'] = Variable<int>(durationSeconds);
    map['completed'] = Variable<bool>(completed);
    map['time_of_day'] = Variable<String>(timeOfDay);
    map['day_of_week'] = Variable<int>(dayOfWeek);
    return map;
  }

  ListeningSessionsCompanion toCompanion(bool nullToAbsent) {
    return ListeningSessionsCompanion(
      id: Value(id),
      songId: Value(songId),
      playedAt: Value(playedAt),
      durationSeconds: Value(durationSeconds),
      completed: Value(completed),
      timeOfDay: Value(timeOfDay),
      dayOfWeek: Value(dayOfWeek),
    );
  }

  factory ListeningSession.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ListeningSession(
      id: serializer.fromJson<int>(json['id']),
      songId: serializer.fromJson<String>(json['songId']),
      playedAt: serializer.fromJson<DateTime>(json['playedAt']),
      durationSeconds: serializer.fromJson<int>(json['durationSeconds']),
      completed: serializer.fromJson<bool>(json['completed']),
      timeOfDay: serializer.fromJson<String>(json['timeOfDay']),
      dayOfWeek: serializer.fromJson<int>(json['dayOfWeek']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'songId': serializer.toJson<String>(songId),
      'playedAt': serializer.toJson<DateTime>(playedAt),
      'durationSeconds': serializer.toJson<int>(durationSeconds),
      'completed': serializer.toJson<bool>(completed),
      'timeOfDay': serializer.toJson<String>(timeOfDay),
      'dayOfWeek': serializer.toJson<int>(dayOfWeek),
    };
  }

  ListeningSession copyWith(
          {int? id,
          String? songId,
          DateTime? playedAt,
          int? durationSeconds,
          bool? completed,
          String? timeOfDay,
          int? dayOfWeek}) =>
      ListeningSession(
        id: id ?? this.id,
        songId: songId ?? this.songId,
        playedAt: playedAt ?? this.playedAt,
        durationSeconds: durationSeconds ?? this.durationSeconds,
        completed: completed ?? this.completed,
        timeOfDay: timeOfDay ?? this.timeOfDay,
        dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      );
  ListeningSession copyWithCompanion(ListeningSessionsCompanion data) {
    return ListeningSession(
      id: data.id.present ? data.id.value : this.id,
      songId: data.songId.present ? data.songId.value : this.songId,
      playedAt: data.playedAt.present ? data.playedAt.value : this.playedAt,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      completed: data.completed.present ? data.completed.value : this.completed,
      timeOfDay: data.timeOfDay.present ? data.timeOfDay.value : this.timeOfDay,
      dayOfWeek: data.dayOfWeek.present ? data.dayOfWeek.value : this.dayOfWeek,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ListeningSession(')
          ..write('id: $id, ')
          ..write('songId: $songId, ')
          ..write('playedAt: $playedAt, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('completed: $completed, ')
          ..write('timeOfDay: $timeOfDay, ')
          ..write('dayOfWeek: $dayOfWeek')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, songId, playedAt, durationSeconds, completed, timeOfDay, dayOfWeek);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ListeningSession &&
          other.id == this.id &&
          other.songId == this.songId &&
          other.playedAt == this.playedAt &&
          other.durationSeconds == this.durationSeconds &&
          other.completed == this.completed &&
          other.timeOfDay == this.timeOfDay &&
          other.dayOfWeek == this.dayOfWeek);
}

class ListeningSessionsCompanion extends UpdateCompanion<ListeningSession> {
  final Value<int> id;
  final Value<String> songId;
  final Value<DateTime> playedAt;
  final Value<int> durationSeconds;
  final Value<bool> completed;
  final Value<String> timeOfDay;
  final Value<int> dayOfWeek;
  const ListeningSessionsCompanion({
    this.id = const Value.absent(),
    this.songId = const Value.absent(),
    this.playedAt = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.completed = const Value.absent(),
    this.timeOfDay = const Value.absent(),
    this.dayOfWeek = const Value.absent(),
  });
  ListeningSessionsCompanion.insert({
    this.id = const Value.absent(),
    required String songId,
    required DateTime playedAt,
    required int durationSeconds,
    this.completed = const Value.absent(),
    required String timeOfDay,
    required int dayOfWeek,
  })  : songId = Value(songId),
        playedAt = Value(playedAt),
        durationSeconds = Value(durationSeconds),
        timeOfDay = Value(timeOfDay),
        dayOfWeek = Value(dayOfWeek);
  static Insertable<ListeningSession> custom({
    Expression<int>? id,
    Expression<String>? songId,
    Expression<DateTime>? playedAt,
    Expression<int>? durationSeconds,
    Expression<bool>? completed,
    Expression<String>? timeOfDay,
    Expression<int>? dayOfWeek,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (songId != null) 'song_id': songId,
      if (playedAt != null) 'played_at': playedAt,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (completed != null) 'completed': completed,
      if (timeOfDay != null) 'time_of_day': timeOfDay,
      if (dayOfWeek != null) 'day_of_week': dayOfWeek,
    });
  }

  ListeningSessionsCompanion copyWith(
      {Value<int>? id,
      Value<String>? songId,
      Value<DateTime>? playedAt,
      Value<int>? durationSeconds,
      Value<bool>? completed,
      Value<String>? timeOfDay,
      Value<int>? dayOfWeek}) {
    return ListeningSessionsCompanion(
      id: id ?? this.id,
      songId: songId ?? this.songId,
      playedAt: playedAt ?? this.playedAt,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      completed: completed ?? this.completed,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
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
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (timeOfDay.present) {
      map['time_of_day'] = Variable<String>(timeOfDay.value);
    }
    if (dayOfWeek.present) {
      map['day_of_week'] = Variable<int>(dayOfWeek.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ListeningSessionsCompanion(')
          ..write('id: $id, ')
          ..write('songId: $songId, ')
          ..write('playedAt: $playedAt, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('completed: $completed, ')
          ..write('timeOfDay: $timeOfDay, ')
          ..write('dayOfWeek: $dayOfWeek')
          ..write(')'))
        .toString();
  }
}

class $RecentSearchesTable extends RecentSearches
    with TableInfo<$RecentSearchesTable, RecentSearche> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecentSearchesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _queryMeta = const VerificationMeta('query');
  @override
  late final GeneratedColumn<String> query = GeneratedColumn<String>(
      'query', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _searchedAtMeta =
      const VerificationMeta('searchedAt');
  @override
  late final GeneratedColumn<DateTime> searchedAt = GeneratedColumn<DateTime>(
      'searched_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [query, searchedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recent_searches';
  @override
  VerificationContext validateIntegrity(Insertable<RecentSearche> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('query')) {
      context.handle(
          _queryMeta, query.isAcceptableOrUnknown(data['query']!, _queryMeta));
    } else if (isInserting) {
      context.missing(_queryMeta);
    }
    if (data.containsKey('searched_at')) {
      context.handle(
          _searchedAtMeta,
          searchedAt.isAcceptableOrUnknown(
              data['searched_at']!, _searchedAtMeta));
    } else if (isInserting) {
      context.missing(_searchedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {query};
  @override
  RecentSearche map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecentSearche(
      query: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}query'])!,
      searchedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}searched_at'])!,
    );
  }

  @override
  $RecentSearchesTable createAlias(String alias) {
    return $RecentSearchesTable(attachedDatabase, alias);
  }
}

class RecentSearche extends DataClass implements Insertable<RecentSearche> {
  final String query;
  final DateTime searchedAt;
  const RecentSearche({required this.query, required this.searchedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['query'] = Variable<String>(query);
    map['searched_at'] = Variable<DateTime>(searchedAt);
    return map;
  }

  RecentSearchesCompanion toCompanion(bool nullToAbsent) {
    return RecentSearchesCompanion(
      query: Value(query),
      searchedAt: Value(searchedAt),
    );
  }

  factory RecentSearche.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecentSearche(
      query: serializer.fromJson<String>(json['query']),
      searchedAt: serializer.fromJson<DateTime>(json['searchedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'query': serializer.toJson<String>(query),
      'searchedAt': serializer.toJson<DateTime>(searchedAt),
    };
  }

  RecentSearche copyWith({String? query, DateTime? searchedAt}) =>
      RecentSearche(
        query: query ?? this.query,
        searchedAt: searchedAt ?? this.searchedAt,
      );
  RecentSearche copyWithCompanion(RecentSearchesCompanion data) {
    return RecentSearche(
      query: data.query.present ? data.query.value : this.query,
      searchedAt:
          data.searchedAt.present ? data.searchedAt.value : this.searchedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecentSearche(')
          ..write('query: $query, ')
          ..write('searchedAt: $searchedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(query, searchedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecentSearche &&
          other.query == this.query &&
          other.searchedAt == this.searchedAt);
}

class RecentSearchesCompanion extends UpdateCompanion<RecentSearche> {
  final Value<String> query;
  final Value<DateTime> searchedAt;
  final Value<int> rowid;
  const RecentSearchesCompanion({
    this.query = const Value.absent(),
    this.searchedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecentSearchesCompanion.insert({
    required String query,
    required DateTime searchedAt,
    this.rowid = const Value.absent(),
  })  : query = Value(query),
        searchedAt = Value(searchedAt);
  static Insertable<RecentSearche> custom({
    Expression<String>? query,
    Expression<DateTime>? searchedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (query != null) 'query': query,
      if (searchedAt != null) 'searched_at': searchedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecentSearchesCompanion copyWith(
      {Value<String>? query, Value<DateTime>? searchedAt, Value<int>? rowid}) {
    return RecentSearchesCompanion(
      query: query ?? this.query,
      searchedAt: searchedAt ?? this.searchedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (query.present) {
      map['query'] = Variable<String>(query.value);
    }
    if (searchedAt.present) {
      map['searched_at'] = Variable<DateTime>(searchedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecentSearchesCompanion(')
          ..write('query: $query, ')
          ..write('searchedAt: $searchedAt, ')
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
  late final $DownloadsTable downloads = $DownloadsTable(this);
  late final $CloudSyncTable cloudSync = $CloudSyncTable(this);
  late final $StreamingCacheTable streamingCache = $StreamingCacheTable(this);
  late final $LyricsCacheTable lyricsCache = $LyricsCacheTable(this);
  late final $AuthenticationTable authentication = $AuthenticationTable(this);
  late final $ProviderSettingsTable providerSettings =
      $ProviderSettingsTable(this);
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  late final $MediaQualityTable mediaQuality = $MediaQualityTable(this);
  late final $PlaybackStatisticsTable playbackStatistics =
      $PlaybackStatisticsTable(this);
  late final $ListeningSessionsTable listeningSessions =
      $ListeningSessionsTable(this);
  late final $RecentSearchesTable recentSearches = $RecentSearchesTable(this);
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
        artworkCacheTable,
        downloads,
        cloudSync,
        streamingCache,
        lyricsCache,
        authentication,
        providerSettings,
        syncQueue,
        mediaQuality,
        playbackStatistics,
        listeningSessions,
        recentSearches
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
typedef $$DownloadsTableCreateCompanionBuilder = DownloadsCompanion Function({
  required String id,
  required String songId,
  required String providerId,
  Value<String?> path,
  required int status,
  required double progress,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$DownloadsTableUpdateCompanionBuilder = DownloadsCompanion Function({
  Value<String> id,
  Value<String> songId,
  Value<String> providerId,
  Value<String?> path,
  Value<int> status,
  Value<double> progress,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$DownloadsTableFilterComposer
    extends Composer<_$AppDatabase, $DownloadsTable> {
  $$DownloadsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get songId => $composableBuilder(
      column: $table.songId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get providerId => $composableBuilder(
      column: $table.providerId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get progress => $composableBuilder(
      column: $table.progress, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$DownloadsTableOrderingComposer
    extends Composer<_$AppDatabase, $DownloadsTable> {
  $$DownloadsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get songId => $composableBuilder(
      column: $table.songId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get providerId => $composableBuilder(
      column: $table.providerId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get progress => $composableBuilder(
      column: $table.progress, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$DownloadsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DownloadsTable> {
  $$DownloadsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get songId =>
      $composableBuilder(column: $table.songId, builder: (column) => column);

  GeneratedColumn<String> get providerId => $composableBuilder(
      column: $table.providerId, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<double> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$DownloadsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DownloadsTable,
    Download,
    $$DownloadsTableFilterComposer,
    $$DownloadsTableOrderingComposer,
    $$DownloadsTableAnnotationComposer,
    $$DownloadsTableCreateCompanionBuilder,
    $$DownloadsTableUpdateCompanionBuilder,
    (Download, BaseReferences<_$AppDatabase, $DownloadsTable, Download>),
    Download,
    PrefetchHooks Function()> {
  $$DownloadsTableTableManager(_$AppDatabase db, $DownloadsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DownloadsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DownloadsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DownloadsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> songId = const Value.absent(),
            Value<String> providerId = const Value.absent(),
            Value<String?> path = const Value.absent(),
            Value<int> status = const Value.absent(),
            Value<double> progress = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DownloadsCompanion(
            id: id,
            songId: songId,
            providerId: providerId,
            path: path,
            status: status,
            progress: progress,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String songId,
            required String providerId,
            Value<String?> path = const Value.absent(),
            required int status,
            required double progress,
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              DownloadsCompanion.insert(
            id: id,
            songId: songId,
            providerId: providerId,
            path: path,
            status: status,
            progress: progress,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DownloadsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DownloadsTable,
    Download,
    $$DownloadsTableFilterComposer,
    $$DownloadsTableOrderingComposer,
    $$DownloadsTableAnnotationComposer,
    $$DownloadsTableCreateCompanionBuilder,
    $$DownloadsTableUpdateCompanionBuilder,
    (Download, BaseReferences<_$AppDatabase, $DownloadsTable, Download>),
    Download,
    PrefetchHooks Function()>;
typedef $$CloudSyncTableCreateCompanionBuilder = CloudSyncCompanion Function({
  required String id,
  required String entityType,
  required String entityId,
  required String providerId,
  required int operation,
  required int version,
  required String syncState,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$CloudSyncTableUpdateCompanionBuilder = CloudSyncCompanion Function({
  Value<String> id,
  Value<String> entityType,
  Value<String> entityId,
  Value<String> providerId,
  Value<int> operation,
  Value<int> version,
  Value<String> syncState,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$CloudSyncTableFilterComposer
    extends Composer<_$AppDatabase, $CloudSyncTable> {
  $$CloudSyncTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get providerId => $composableBuilder(
      column: $table.providerId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$CloudSyncTableOrderingComposer
    extends Composer<_$AppDatabase, $CloudSyncTable> {
  $$CloudSyncTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get providerId => $composableBuilder(
      column: $table.providerId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncState => $composableBuilder(
      column: $table.syncState, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$CloudSyncTableAnnotationComposer
    extends Composer<_$AppDatabase, $CloudSyncTable> {
  $$CloudSyncTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => column);

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get providerId => $composableBuilder(
      column: $table.providerId, builder: (column) => column);

  GeneratedColumn<int> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get syncState =>
      $composableBuilder(column: $table.syncState, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CloudSyncTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CloudSyncTable,
    CloudSyncData,
    $$CloudSyncTableFilterComposer,
    $$CloudSyncTableOrderingComposer,
    $$CloudSyncTableAnnotationComposer,
    $$CloudSyncTableCreateCompanionBuilder,
    $$CloudSyncTableUpdateCompanionBuilder,
    (
      CloudSyncData,
      BaseReferences<_$AppDatabase, $CloudSyncTable, CloudSyncData>
    ),
    CloudSyncData,
    PrefetchHooks Function()> {
  $$CloudSyncTableTableManager(_$AppDatabase db, $CloudSyncTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CloudSyncTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CloudSyncTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CloudSyncTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> entityType = const Value.absent(),
            Value<String> entityId = const Value.absent(),
            Value<String> providerId = const Value.absent(),
            Value<int> operation = const Value.absent(),
            Value<int> version = const Value.absent(),
            Value<String> syncState = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CloudSyncCompanion(
            id: id,
            entityType: entityType,
            entityId: entityId,
            providerId: providerId,
            operation: operation,
            version: version,
            syncState: syncState,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String entityType,
            required String entityId,
            required String providerId,
            required int operation,
            required int version,
            required String syncState,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              CloudSyncCompanion.insert(
            id: id,
            entityType: entityType,
            entityId: entityId,
            providerId: providerId,
            operation: operation,
            version: version,
            syncState: syncState,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CloudSyncTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CloudSyncTable,
    CloudSyncData,
    $$CloudSyncTableFilterComposer,
    $$CloudSyncTableOrderingComposer,
    $$CloudSyncTableAnnotationComposer,
    $$CloudSyncTableCreateCompanionBuilder,
    $$CloudSyncTableUpdateCompanionBuilder,
    (
      CloudSyncData,
      BaseReferences<_$AppDatabase, $CloudSyncTable, CloudSyncData>
    ),
    CloudSyncData,
    PrefetchHooks Function()>;
typedef $$StreamingCacheTableCreateCompanionBuilder = StreamingCacheCompanion
    Function({
  required String key,
  required String providerId,
  required String path,
  required int size,
  required DateTime lastAccessedAt,
  Value<int> rowid,
});
typedef $$StreamingCacheTableUpdateCompanionBuilder = StreamingCacheCompanion
    Function({
  Value<String> key,
  Value<String> providerId,
  Value<String> path,
  Value<int> size,
  Value<DateTime> lastAccessedAt,
  Value<int> rowid,
});

class $$StreamingCacheTableFilterComposer
    extends Composer<_$AppDatabase, $StreamingCacheTable> {
  $$StreamingCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get providerId => $composableBuilder(
      column: $table.providerId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get size => $composableBuilder(
      column: $table.size, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastAccessedAt => $composableBuilder(
      column: $table.lastAccessedAt,
      builder: (column) => ColumnFilters(column));
}

class $$StreamingCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $StreamingCacheTable> {
  $$StreamingCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get providerId => $composableBuilder(
      column: $table.providerId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get path => $composableBuilder(
      column: $table.path, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get size => $composableBuilder(
      column: $table.size, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastAccessedAt => $composableBuilder(
      column: $table.lastAccessedAt,
      builder: (column) => ColumnOrderings(column));
}

class $$StreamingCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $StreamingCacheTable> {
  $$StreamingCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get providerId => $composableBuilder(
      column: $table.providerId, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<int> get size =>
      $composableBuilder(column: $table.size, builder: (column) => column);

  GeneratedColumn<DateTime> get lastAccessedAt => $composableBuilder(
      column: $table.lastAccessedAt, builder: (column) => column);
}

class $$StreamingCacheTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StreamingCacheTable,
    StreamingCacheData,
    $$StreamingCacheTableFilterComposer,
    $$StreamingCacheTableOrderingComposer,
    $$StreamingCacheTableAnnotationComposer,
    $$StreamingCacheTableCreateCompanionBuilder,
    $$StreamingCacheTableUpdateCompanionBuilder,
    (
      StreamingCacheData,
      BaseReferences<_$AppDatabase, $StreamingCacheTable, StreamingCacheData>
    ),
    StreamingCacheData,
    PrefetchHooks Function()> {
  $$StreamingCacheTableTableManager(
      _$AppDatabase db, $StreamingCacheTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StreamingCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StreamingCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StreamingCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> providerId = const Value.absent(),
            Value<String> path = const Value.absent(),
            Value<int> size = const Value.absent(),
            Value<DateTime> lastAccessedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              StreamingCacheCompanion(
            key: key,
            providerId: providerId,
            path: path,
            size: size,
            lastAccessedAt: lastAccessedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String providerId,
            required String path,
            required int size,
            required DateTime lastAccessedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              StreamingCacheCompanion.insert(
            key: key,
            providerId: providerId,
            path: path,
            size: size,
            lastAccessedAt: lastAccessedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$StreamingCacheTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $StreamingCacheTable,
    StreamingCacheData,
    $$StreamingCacheTableFilterComposer,
    $$StreamingCacheTableOrderingComposer,
    $$StreamingCacheTableAnnotationComposer,
    $$StreamingCacheTableCreateCompanionBuilder,
    $$StreamingCacheTableUpdateCompanionBuilder,
    (
      StreamingCacheData,
      BaseReferences<_$AppDatabase, $StreamingCacheTable, StreamingCacheData>
    ),
    StreamingCacheData,
    PrefetchHooks Function()>;
typedef $$LyricsCacheTableCreateCompanionBuilder = LyricsCacheCompanion
    Function({
  required String songId,
  required String providerId,
  required String content,
  Value<bool> isSynced,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$LyricsCacheTableUpdateCompanionBuilder = LyricsCacheCompanion
    Function({
  Value<String> songId,
  Value<String> providerId,
  Value<String> content,
  Value<bool> isSynced,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$LyricsCacheTableFilterComposer
    extends Composer<_$AppDatabase, $LyricsCacheTable> {
  $$LyricsCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get songId => $composableBuilder(
      column: $table.songId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get providerId => $composableBuilder(
      column: $table.providerId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$LyricsCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $LyricsCacheTable> {
  $$LyricsCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get songId => $composableBuilder(
      column: $table.songId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get providerId => $composableBuilder(
      column: $table.providerId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynced => $composableBuilder(
      column: $table.isSynced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$LyricsCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $LyricsCacheTable> {
  $$LyricsCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get songId =>
      $composableBuilder(column: $table.songId, builder: (column) => column);

  GeneratedColumn<String> get providerId => $composableBuilder(
      column: $table.providerId, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LyricsCacheTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LyricsCacheTable,
    LyricsCacheData,
    $$LyricsCacheTableFilterComposer,
    $$LyricsCacheTableOrderingComposer,
    $$LyricsCacheTableAnnotationComposer,
    $$LyricsCacheTableCreateCompanionBuilder,
    $$LyricsCacheTableUpdateCompanionBuilder,
    (
      LyricsCacheData,
      BaseReferences<_$AppDatabase, $LyricsCacheTable, LyricsCacheData>
    ),
    LyricsCacheData,
    PrefetchHooks Function()> {
  $$LyricsCacheTableTableManager(_$AppDatabase db, $LyricsCacheTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LyricsCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LyricsCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LyricsCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> songId = const Value.absent(),
            Value<String> providerId = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<bool> isSynced = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LyricsCacheCompanion(
            songId: songId,
            providerId: providerId,
            content: content,
            isSynced: isSynced,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String songId,
            required String providerId,
            required String content,
            Value<bool> isSynced = const Value.absent(),
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              LyricsCacheCompanion.insert(
            songId: songId,
            providerId: providerId,
            content: content,
            isSynced: isSynced,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LyricsCacheTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LyricsCacheTable,
    LyricsCacheData,
    $$LyricsCacheTableFilterComposer,
    $$LyricsCacheTableOrderingComposer,
    $$LyricsCacheTableAnnotationComposer,
    $$LyricsCacheTableCreateCompanionBuilder,
    $$LyricsCacheTableUpdateCompanionBuilder,
    (
      LyricsCacheData,
      BaseReferences<_$AppDatabase, $LyricsCacheTable, LyricsCacheData>
    ),
    LyricsCacheData,
    PrefetchHooks Function()>;
typedef $$AuthenticationTableCreateCompanionBuilder = AuthenticationCompanion
    Function({
  required String providerId,
  required String userId,
  Value<bool> isLoggedIn,
  Value<String?> displayName,
  Value<String?> avatarUrl,
  Value<int> rowid,
});
typedef $$AuthenticationTableUpdateCompanionBuilder = AuthenticationCompanion
    Function({
  Value<String> providerId,
  Value<String> userId,
  Value<bool> isLoggedIn,
  Value<String?> displayName,
  Value<String?> avatarUrl,
  Value<int> rowid,
});

class $$AuthenticationTableFilterComposer
    extends Composer<_$AppDatabase, $AuthenticationTable> {
  $$AuthenticationTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get providerId => $composableBuilder(
      column: $table.providerId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isLoggedIn => $composableBuilder(
      column: $table.isLoggedIn, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get avatarUrl => $composableBuilder(
      column: $table.avatarUrl, builder: (column) => ColumnFilters(column));
}

class $$AuthenticationTableOrderingComposer
    extends Composer<_$AppDatabase, $AuthenticationTable> {
  $$AuthenticationTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get providerId => $composableBuilder(
      column: $table.providerId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isLoggedIn => $composableBuilder(
      column: $table.isLoggedIn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
      column: $table.avatarUrl, builder: (column) => ColumnOrderings(column));
}

class $$AuthenticationTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuthenticationTable> {
  $$AuthenticationTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get providerId => $composableBuilder(
      column: $table.providerId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<bool> get isLoggedIn => $composableBuilder(
      column: $table.isLoggedIn, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
      column: $table.displayName, builder: (column) => column);

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);
}

class $$AuthenticationTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AuthenticationTable,
    AuthenticationData,
    $$AuthenticationTableFilterComposer,
    $$AuthenticationTableOrderingComposer,
    $$AuthenticationTableAnnotationComposer,
    $$AuthenticationTableCreateCompanionBuilder,
    $$AuthenticationTableUpdateCompanionBuilder,
    (
      AuthenticationData,
      BaseReferences<_$AppDatabase, $AuthenticationTable, AuthenticationData>
    ),
    AuthenticationData,
    PrefetchHooks Function()> {
  $$AuthenticationTableTableManager(
      _$AppDatabase db, $AuthenticationTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuthenticationTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuthenticationTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuthenticationTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> providerId = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<bool> isLoggedIn = const Value.absent(),
            Value<String?> displayName = const Value.absent(),
            Value<String?> avatarUrl = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AuthenticationCompanion(
            providerId: providerId,
            userId: userId,
            isLoggedIn: isLoggedIn,
            displayName: displayName,
            avatarUrl: avatarUrl,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String providerId,
            required String userId,
            Value<bool> isLoggedIn = const Value.absent(),
            Value<String?> displayName = const Value.absent(),
            Value<String?> avatarUrl = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AuthenticationCompanion.insert(
            providerId: providerId,
            userId: userId,
            isLoggedIn: isLoggedIn,
            displayName: displayName,
            avatarUrl: avatarUrl,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AuthenticationTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AuthenticationTable,
    AuthenticationData,
    $$AuthenticationTableFilterComposer,
    $$AuthenticationTableOrderingComposer,
    $$AuthenticationTableAnnotationComposer,
    $$AuthenticationTableCreateCompanionBuilder,
    $$AuthenticationTableUpdateCompanionBuilder,
    (
      AuthenticationData,
      BaseReferences<_$AppDatabase, $AuthenticationTable, AuthenticationData>
    ),
    AuthenticationData,
    PrefetchHooks Function()>;
typedef $$ProviderSettingsTableCreateCompanionBuilder
    = ProviderSettingsCompanion Function({
  required String id,
  Value<bool> enabled,
  Value<int> priority,
  Value<String> healthStatus,
  Value<int> rowid,
});
typedef $$ProviderSettingsTableUpdateCompanionBuilder
    = ProviderSettingsCompanion Function({
  Value<String> id,
  Value<bool> enabled,
  Value<int> priority,
  Value<String> healthStatus,
  Value<int> rowid,
});

class $$ProviderSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $ProviderSettingsTable> {
  $$ProviderSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get enabled => $composableBuilder(
      column: $table.enabled, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get healthStatus => $composableBuilder(
      column: $table.healthStatus, builder: (column) => ColumnFilters(column));
}

class $$ProviderSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProviderSettingsTable> {
  $$ProviderSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get enabled => $composableBuilder(
      column: $table.enabled, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get healthStatus => $composableBuilder(
      column: $table.healthStatus,
      builder: (column) => ColumnOrderings(column));
}

class $$ProviderSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProviderSettingsTable> {
  $$ProviderSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get healthStatus => $composableBuilder(
      column: $table.healthStatus, builder: (column) => column);
}

class $$ProviderSettingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProviderSettingsTable,
    ProviderSetting,
    $$ProviderSettingsTableFilterComposer,
    $$ProviderSettingsTableOrderingComposer,
    $$ProviderSettingsTableAnnotationComposer,
    $$ProviderSettingsTableCreateCompanionBuilder,
    $$ProviderSettingsTableUpdateCompanionBuilder,
    (
      ProviderSetting,
      BaseReferences<_$AppDatabase, $ProviderSettingsTable, ProviderSetting>
    ),
    ProviderSetting,
    PrefetchHooks Function()> {
  $$ProviderSettingsTableTableManager(
      _$AppDatabase db, $ProviderSettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProviderSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProviderSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProviderSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<bool> enabled = const Value.absent(),
            Value<int> priority = const Value.absent(),
            Value<String> healthStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProviderSettingsCompanion(
            id: id,
            enabled: enabled,
            priority: priority,
            healthStatus: healthStatus,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<bool> enabled = const Value.absent(),
            Value<int> priority = const Value.absent(),
            Value<String> healthStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProviderSettingsCompanion.insert(
            id: id,
            enabled: enabled,
            priority: priority,
            healthStatus: healthStatus,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ProviderSettingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProviderSettingsTable,
    ProviderSetting,
    $$ProviderSettingsTableFilterComposer,
    $$ProviderSettingsTableOrderingComposer,
    $$ProviderSettingsTableAnnotationComposer,
    $$ProviderSettingsTableCreateCompanionBuilder,
    $$ProviderSettingsTableUpdateCompanionBuilder,
    (
      ProviderSetting,
      BaseReferences<_$AppDatabase, $ProviderSettingsTable, ProviderSetting>
    ),
    ProviderSetting,
    PrefetchHooks Function()>;
typedef $$SyncQueueTableCreateCompanionBuilder = SyncQueueCompanion Function({
  Value<int> id,
  required String syncTableName,
  required String recordId,
  required String operation,
  required String payload,
  Value<int> retries,
});
typedef $$SyncQueueTableUpdateCompanionBuilder = SyncQueueCompanion Function({
  Value<int> id,
  Value<String> syncTableName,
  Value<String> recordId,
  Value<String> operation,
  Value<String> payload,
  Value<int> retries,
});

class $$SyncQueueTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncTableName => $composableBuilder(
      column: $table.syncTableName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get recordId => $composableBuilder(
      column: $table.recordId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get retries => $composableBuilder(
      column: $table.retries, builder: (column) => ColumnFilters(column));
}

class $$SyncQueueTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncTableName => $composableBuilder(
      column: $table.syncTableName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get recordId => $composableBuilder(
      column: $table.recordId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get retries => $composableBuilder(
      column: $table.retries, builder: (column) => ColumnOrderings(column));
}

class $$SyncQueueTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get syncTableName => $composableBuilder(
      column: $table.syncTableName, builder: (column) => column);

  GeneratedColumn<String> get recordId =>
      $composableBuilder(column: $table.recordId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<int> get retries =>
      $composableBuilder(column: $table.retries, builder: (column) => column);
}

class $$SyncQueueTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncQueueTable,
    SyncQueueData,
    $$SyncQueueTableFilterComposer,
    $$SyncQueueTableOrderingComposer,
    $$SyncQueueTableAnnotationComposer,
    $$SyncQueueTableCreateCompanionBuilder,
    $$SyncQueueTableUpdateCompanionBuilder,
    (
      SyncQueueData,
      BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>
    ),
    SyncQueueData,
    PrefetchHooks Function()> {
  $$SyncQueueTableTableManager(_$AppDatabase db, $SyncQueueTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> syncTableName = const Value.absent(),
            Value<String> recordId = const Value.absent(),
            Value<String> operation = const Value.absent(),
            Value<String> payload = const Value.absent(),
            Value<int> retries = const Value.absent(),
          }) =>
              SyncQueueCompanion(
            id: id,
            syncTableName: syncTableName,
            recordId: recordId,
            operation: operation,
            payload: payload,
            retries: retries,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String syncTableName,
            required String recordId,
            required String operation,
            required String payload,
            Value<int> retries = const Value.absent(),
          }) =>
              SyncQueueCompanion.insert(
            id: id,
            syncTableName: syncTableName,
            recordId: recordId,
            operation: operation,
            payload: payload,
            retries: retries,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncQueueTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncQueueTable,
    SyncQueueData,
    $$SyncQueueTableFilterComposer,
    $$SyncQueueTableOrderingComposer,
    $$SyncQueueTableAnnotationComposer,
    $$SyncQueueTableCreateCompanionBuilder,
    $$SyncQueueTableUpdateCompanionBuilder,
    (
      SyncQueueData,
      BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>
    ),
    SyncQueueData,
    PrefetchHooks Function()>;
typedef $$MediaQualityTableCreateCompanionBuilder = MediaQualityCompanion
    Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$MediaQualityTableUpdateCompanionBuilder = MediaQualityCompanion
    Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$MediaQualityTableFilterComposer
    extends Composer<_$AppDatabase, $MediaQualityTable> {
  $$MediaQualityTableFilterComposer({
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

class $$MediaQualityTableOrderingComposer
    extends Composer<_$AppDatabase, $MediaQualityTable> {
  $$MediaQualityTableOrderingComposer({
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

class $$MediaQualityTableAnnotationComposer
    extends Composer<_$AppDatabase, $MediaQualityTable> {
  $$MediaQualityTableAnnotationComposer({
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

class $$MediaQualityTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MediaQualityTable,
    MediaQualityData,
    $$MediaQualityTableFilterComposer,
    $$MediaQualityTableOrderingComposer,
    $$MediaQualityTableAnnotationComposer,
    $$MediaQualityTableCreateCompanionBuilder,
    $$MediaQualityTableUpdateCompanionBuilder,
    (
      MediaQualityData,
      BaseReferences<_$AppDatabase, $MediaQualityTable, MediaQualityData>
    ),
    MediaQualityData,
    PrefetchHooks Function()> {
  $$MediaQualityTableTableManager(_$AppDatabase db, $MediaQualityTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MediaQualityTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MediaQualityTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MediaQualityTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MediaQualityCompanion(
            key: key,
            value: value,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) =>
              MediaQualityCompanion.insert(
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

typedef $$MediaQualityTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MediaQualityTable,
    MediaQualityData,
    $$MediaQualityTableFilterComposer,
    $$MediaQualityTableOrderingComposer,
    $$MediaQualityTableAnnotationComposer,
    $$MediaQualityTableCreateCompanionBuilder,
    $$MediaQualityTableUpdateCompanionBuilder,
    (
      MediaQualityData,
      BaseReferences<_$AppDatabase, $MediaQualityTable, MediaQualityData>
    ),
    MediaQualityData,
    PrefetchHooks Function()>;
typedef $$PlaybackStatisticsTableCreateCompanionBuilder
    = PlaybackStatisticsCompanion Function({
  required String songId,
  Value<int> playCount,
  Value<int> skipCount,
  Value<double> completionRate,
  Value<DateTime?> lastPlayedAt,
  Value<int> rowid,
});
typedef $$PlaybackStatisticsTableUpdateCompanionBuilder
    = PlaybackStatisticsCompanion Function({
  Value<String> songId,
  Value<int> playCount,
  Value<int> skipCount,
  Value<double> completionRate,
  Value<DateTime?> lastPlayedAt,
  Value<int> rowid,
});

class $$PlaybackStatisticsTableFilterComposer
    extends Composer<_$AppDatabase, $PlaybackStatisticsTable> {
  $$PlaybackStatisticsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get songId => $composableBuilder(
      column: $table.songId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get playCount => $composableBuilder(
      column: $table.playCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get skipCount => $composableBuilder(
      column: $table.skipCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get completionRate => $composableBuilder(
      column: $table.completionRate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastPlayedAt => $composableBuilder(
      column: $table.lastPlayedAt, builder: (column) => ColumnFilters(column));
}

class $$PlaybackStatisticsTableOrderingComposer
    extends Composer<_$AppDatabase, $PlaybackStatisticsTable> {
  $$PlaybackStatisticsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get songId => $composableBuilder(
      column: $table.songId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get playCount => $composableBuilder(
      column: $table.playCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get skipCount => $composableBuilder(
      column: $table.skipCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get completionRate => $composableBuilder(
      column: $table.completionRate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastPlayedAt => $composableBuilder(
      column: $table.lastPlayedAt,
      builder: (column) => ColumnOrderings(column));
}

class $$PlaybackStatisticsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlaybackStatisticsTable> {
  $$PlaybackStatisticsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get songId =>
      $composableBuilder(column: $table.songId, builder: (column) => column);

  GeneratedColumn<int> get playCount =>
      $composableBuilder(column: $table.playCount, builder: (column) => column);

  GeneratedColumn<int> get skipCount =>
      $composableBuilder(column: $table.skipCount, builder: (column) => column);

  GeneratedColumn<double> get completionRate => $composableBuilder(
      column: $table.completionRate, builder: (column) => column);

  GeneratedColumn<DateTime> get lastPlayedAt => $composableBuilder(
      column: $table.lastPlayedAt, builder: (column) => column);
}

class $$PlaybackStatisticsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PlaybackStatisticsTable,
    PlaybackStatistic,
    $$PlaybackStatisticsTableFilterComposer,
    $$PlaybackStatisticsTableOrderingComposer,
    $$PlaybackStatisticsTableAnnotationComposer,
    $$PlaybackStatisticsTableCreateCompanionBuilder,
    $$PlaybackStatisticsTableUpdateCompanionBuilder,
    (
      PlaybackStatistic,
      BaseReferences<_$AppDatabase, $PlaybackStatisticsTable, PlaybackStatistic>
    ),
    PlaybackStatistic,
    PrefetchHooks Function()> {
  $$PlaybackStatisticsTableTableManager(
      _$AppDatabase db, $PlaybackStatisticsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlaybackStatisticsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlaybackStatisticsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlaybackStatisticsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> songId = const Value.absent(),
            Value<int> playCount = const Value.absent(),
            Value<int> skipCount = const Value.absent(),
            Value<double> completionRate = const Value.absent(),
            Value<DateTime?> lastPlayedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PlaybackStatisticsCompanion(
            songId: songId,
            playCount: playCount,
            skipCount: skipCount,
            completionRate: completionRate,
            lastPlayedAt: lastPlayedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String songId,
            Value<int> playCount = const Value.absent(),
            Value<int> skipCount = const Value.absent(),
            Value<double> completionRate = const Value.absent(),
            Value<DateTime?> lastPlayedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PlaybackStatisticsCompanion.insert(
            songId: songId,
            playCount: playCount,
            skipCount: skipCount,
            completionRate: completionRate,
            lastPlayedAt: lastPlayedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PlaybackStatisticsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PlaybackStatisticsTable,
    PlaybackStatistic,
    $$PlaybackStatisticsTableFilterComposer,
    $$PlaybackStatisticsTableOrderingComposer,
    $$PlaybackStatisticsTableAnnotationComposer,
    $$PlaybackStatisticsTableCreateCompanionBuilder,
    $$PlaybackStatisticsTableUpdateCompanionBuilder,
    (
      PlaybackStatistic,
      BaseReferences<_$AppDatabase, $PlaybackStatisticsTable, PlaybackStatistic>
    ),
    PlaybackStatistic,
    PrefetchHooks Function()>;
typedef $$ListeningSessionsTableCreateCompanionBuilder
    = ListeningSessionsCompanion Function({
  Value<int> id,
  required String songId,
  required DateTime playedAt,
  required int durationSeconds,
  Value<bool> completed,
  required String timeOfDay,
  required int dayOfWeek,
});
typedef $$ListeningSessionsTableUpdateCompanionBuilder
    = ListeningSessionsCompanion Function({
  Value<int> id,
  Value<String> songId,
  Value<DateTime> playedAt,
  Value<int> durationSeconds,
  Value<bool> completed,
  Value<String> timeOfDay,
  Value<int> dayOfWeek,
});

class $$ListeningSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $ListeningSessionsTable> {
  $$ListeningSessionsTableFilterComposer({
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

  ColumnFilters<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get completed => $composableBuilder(
      column: $table.completed, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get timeOfDay => $composableBuilder(
      column: $table.timeOfDay, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get dayOfWeek => $composableBuilder(
      column: $table.dayOfWeek, builder: (column) => ColumnFilters(column));
}

class $$ListeningSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ListeningSessionsTable> {
  $$ListeningSessionsTableOrderingComposer({
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

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get completed => $composableBuilder(
      column: $table.completed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get timeOfDay => $composableBuilder(
      column: $table.timeOfDay, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get dayOfWeek => $composableBuilder(
      column: $table.dayOfWeek, builder: (column) => ColumnOrderings(column));
}

class $$ListeningSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ListeningSessionsTable> {
  $$ListeningSessionsTableAnnotationComposer({
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

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds, builder: (column) => column);

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<String> get timeOfDay =>
      $composableBuilder(column: $table.timeOfDay, builder: (column) => column);

  GeneratedColumn<int> get dayOfWeek =>
      $composableBuilder(column: $table.dayOfWeek, builder: (column) => column);
}

class $$ListeningSessionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ListeningSessionsTable,
    ListeningSession,
    $$ListeningSessionsTableFilterComposer,
    $$ListeningSessionsTableOrderingComposer,
    $$ListeningSessionsTableAnnotationComposer,
    $$ListeningSessionsTableCreateCompanionBuilder,
    $$ListeningSessionsTableUpdateCompanionBuilder,
    (
      ListeningSession,
      BaseReferences<_$AppDatabase, $ListeningSessionsTable, ListeningSession>
    ),
    ListeningSession,
    PrefetchHooks Function()> {
  $$ListeningSessionsTableTableManager(
      _$AppDatabase db, $ListeningSessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ListeningSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ListeningSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ListeningSessionsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> songId = const Value.absent(),
            Value<DateTime> playedAt = const Value.absent(),
            Value<int> durationSeconds = const Value.absent(),
            Value<bool> completed = const Value.absent(),
            Value<String> timeOfDay = const Value.absent(),
            Value<int> dayOfWeek = const Value.absent(),
          }) =>
              ListeningSessionsCompanion(
            id: id,
            songId: songId,
            playedAt: playedAt,
            durationSeconds: durationSeconds,
            completed: completed,
            timeOfDay: timeOfDay,
            dayOfWeek: dayOfWeek,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String songId,
            required DateTime playedAt,
            required int durationSeconds,
            Value<bool> completed = const Value.absent(),
            required String timeOfDay,
            required int dayOfWeek,
          }) =>
              ListeningSessionsCompanion.insert(
            id: id,
            songId: songId,
            playedAt: playedAt,
            durationSeconds: durationSeconds,
            completed: completed,
            timeOfDay: timeOfDay,
            dayOfWeek: dayOfWeek,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ListeningSessionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ListeningSessionsTable,
    ListeningSession,
    $$ListeningSessionsTableFilterComposer,
    $$ListeningSessionsTableOrderingComposer,
    $$ListeningSessionsTableAnnotationComposer,
    $$ListeningSessionsTableCreateCompanionBuilder,
    $$ListeningSessionsTableUpdateCompanionBuilder,
    (
      ListeningSession,
      BaseReferences<_$AppDatabase, $ListeningSessionsTable, ListeningSession>
    ),
    ListeningSession,
    PrefetchHooks Function()>;
typedef $$RecentSearchesTableCreateCompanionBuilder = RecentSearchesCompanion
    Function({
  required String query,
  required DateTime searchedAt,
  Value<int> rowid,
});
typedef $$RecentSearchesTableUpdateCompanionBuilder = RecentSearchesCompanion
    Function({
  Value<String> query,
  Value<DateTime> searchedAt,
  Value<int> rowid,
});

class $$RecentSearchesTableFilterComposer
    extends Composer<_$AppDatabase, $RecentSearchesTable> {
  $$RecentSearchesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get query => $composableBuilder(
      column: $table.query, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get searchedAt => $composableBuilder(
      column: $table.searchedAt, builder: (column) => ColumnFilters(column));
}

class $$RecentSearchesTableOrderingComposer
    extends Composer<_$AppDatabase, $RecentSearchesTable> {
  $$RecentSearchesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get query => $composableBuilder(
      column: $table.query, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get searchedAt => $composableBuilder(
      column: $table.searchedAt, builder: (column) => ColumnOrderings(column));
}

class $$RecentSearchesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecentSearchesTable> {
  $$RecentSearchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get query =>
      $composableBuilder(column: $table.query, builder: (column) => column);

  GeneratedColumn<DateTime> get searchedAt => $composableBuilder(
      column: $table.searchedAt, builder: (column) => column);
}

class $$RecentSearchesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RecentSearchesTable,
    RecentSearche,
    $$RecentSearchesTableFilterComposer,
    $$RecentSearchesTableOrderingComposer,
    $$RecentSearchesTableAnnotationComposer,
    $$RecentSearchesTableCreateCompanionBuilder,
    $$RecentSearchesTableUpdateCompanionBuilder,
    (
      RecentSearche,
      BaseReferences<_$AppDatabase, $RecentSearchesTable, RecentSearche>
    ),
    RecentSearche,
    PrefetchHooks Function()> {
  $$RecentSearchesTableTableManager(
      _$AppDatabase db, $RecentSearchesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecentSearchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecentSearchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecentSearchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> query = const Value.absent(),
            Value<DateTime> searchedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RecentSearchesCompanion(
            query: query,
            searchedAt: searchedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String query,
            required DateTime searchedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              RecentSearchesCompanion.insert(
            query: query,
            searchedAt: searchedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RecentSearchesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RecentSearchesTable,
    RecentSearche,
    $$RecentSearchesTableFilterComposer,
    $$RecentSearchesTableOrderingComposer,
    $$RecentSearchesTableAnnotationComposer,
    $$RecentSearchesTableCreateCompanionBuilder,
    $$RecentSearchesTableUpdateCompanionBuilder,
    (
      RecentSearche,
      BaseReferences<_$AppDatabase, $RecentSearchesTable, RecentSearche>
    ),
    RecentSearche,
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
  $$DownloadsTableTableManager get downloads =>
      $$DownloadsTableTableManager(_db, _db.downloads);
  $$CloudSyncTableTableManager get cloudSync =>
      $$CloudSyncTableTableManager(_db, _db.cloudSync);
  $$StreamingCacheTableTableManager get streamingCache =>
      $$StreamingCacheTableTableManager(_db, _db.streamingCache);
  $$LyricsCacheTableTableManager get lyricsCache =>
      $$LyricsCacheTableTableManager(_db, _db.lyricsCache);
  $$AuthenticationTableTableManager get authentication =>
      $$AuthenticationTableTableManager(_db, _db.authentication);
  $$ProviderSettingsTableTableManager get providerSettings =>
      $$ProviderSettingsTableTableManager(_db, _db.providerSettings);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
  $$MediaQualityTableTableManager get mediaQuality =>
      $$MediaQualityTableTableManager(_db, _db.mediaQuality);
  $$PlaybackStatisticsTableTableManager get playbackStatistics =>
      $$PlaybackStatisticsTableTableManager(_db, _db.playbackStatistics);
  $$ListeningSessionsTableTableManager get listeningSessions =>
      $$ListeningSessionsTableTableManager(_db, _db.listeningSessions);
  $$RecentSearchesTableTableManager get recentSearches =>
      $$RecentSearchesTableTableManager(_db, _db.recentSearches);
}
