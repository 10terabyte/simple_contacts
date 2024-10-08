// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again
// with `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'
    as obx_int; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart' as obx;
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'models/address.dart';
import 'models/contact.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <obx_int.ModelEntity>[
  obx_int.ModelEntity(
      id: const obx_int.IdUid(1, 1961467083135581589),
      name: 'Contact',
      lastPropertyId: const obx_int.IdUid(11, 1381903175566405588),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 8028710169063990990),
            name: 'id',
            type: 6,
            flags: 129),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 653446820829815835),
            name: 'firstName',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 4871863322978988147),
            name: 'lastName',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(10, 589834910043363366),
            name: 'phoneNumbers',
            type: 30,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[
        obx_int.ModelBacklink(
            name: 'addresses', srcEntity: 'Address', srcField: 'contact')
      ]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(2, 1657300384737860789),
      name: 'Address',
      lastPropertyId: const obx_int.IdUid(7, 4284561414546143757),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 3522814237838160574),
            name: 'id',
            type: 6,
            flags: 129),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 4059811243744146330),
            name: 'streetAddress1',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 8431771795928909626),
            name: 'streetAddress2',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 5996960447886936407),
            name: 'city',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(5, 293474323338885072),
            name: 'state',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(6, 9042002998025909000),
            name: 'zipCode',
            type: 9,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(7, 4284561414546143757),
            name: 'contactId',
            type: 11,
            flags: 520,
            indexId: const obx_int.IdUid(1, 8439258140377494857),
            relationTarget: 'Contact')
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[])
];

/// Shortcut for [obx.Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [obx.Store.new] for an explanation of all parameters.
///
/// For Flutter apps, also calls `loadObjectBoxLibraryAndroidCompat()` from
/// the ObjectBox Flutter library to fix loading the native ObjectBox library
/// on Android 6 and older.
Future<obx.Store> openStore(
    {String? directory,
    int? maxDBSizeInKB,
    int? maxDataSizeInKB,
    int? fileMode,
    int? maxReaders,
    bool queriesCaseSensitiveDefault = true,
    String? macosApplicationGroup}) async {
  await loadObjectBoxLibraryAndroidCompat();
  return obx.Store(getObjectBoxModel(),
      directory: directory ?? (await defaultStoreDirectory()).path,
      maxDBSizeInKB: maxDBSizeInKB,
      maxDataSizeInKB: maxDataSizeInKB,
      fileMode: fileMode,
      maxReaders: maxReaders,
      queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
      macosApplicationGroup: macosApplicationGroup);
}

/// Returns the ObjectBox model definition for this project for use with
/// [obx.Store.new].
obx_int.ModelDefinition getObjectBoxModel() {
  final model = obx_int.ModelInfo(
      entities: _entities,
      lastEntityId: const obx_int.IdUid(2, 1657300384737860789),
      lastIndexId: const obx_int.IdUid(1, 8439258140377494857),
      lastRelationId: const obx_int.IdUid(0, 0),
      lastSequenceId: const obx_int.IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [
        2191058221583018979,
        1555396088587815962,
        8877174791429193370,
        8411424866941062653,
        6357419244582019925,
        4893102149097721238,
        1381903175566405588
      ],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, obx_int.EntityDefinition>{
    Contact: obx_int.EntityDefinition<Contact>(
        model: _entities[0],
        toOneRelations: (Contact object) => [],
        toManyRelations: (Contact object) => {
              obx_int.RelInfo<Address>.toOneBacklink(
                      7, object.id, (Address srcObject) => srcObject.contact):
                  object.addresses
            },
        getId: (Contact object) => object.id,
        setId: (Contact object, int id) {
          object.id = id;
        },
        objectToFB: (Contact object, fb.Builder fbb) {
          final firstNameOffset = fbb.writeString(object.firstName);
          final lastNameOffset = fbb.writeString(object.lastName);
          final phoneNumbersOffset = fbb.writeList(
              object.phoneNumbers.map(fbb.writeString).toList(growable: false));
          fbb.startTable(12);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, firstNameOffset);
          fbb.addOffset(2, lastNameOffset);
          fbb.addOffset(9, phoneNumbersOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final firstNameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final lastNameParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 8, '');
          final phoneNumbersParam = const fb.ListReader<String>(
                  fb.StringReader(asciiOptimization: true),
                  lazy: false)
              .vTableGet(buffer, rootOffset, 22, []);
          final object = Contact(
              id: idParam,
              firstName: firstNameParam,
              lastName: lastNameParam,
              phoneNumbers: phoneNumbersParam);
          obx_int.InternalToManyAccess.setRelInfo<Contact>(
              object.addresses,
              store,
              obx_int.RelInfo<Address>.toOneBacklink(
                  7, object.id, (Address srcObject) => srcObject.contact));
          return object;
        }),
    Address: obx_int.EntityDefinition<Address>(
        model: _entities[1],
        toOneRelations: (Address object) => [object.contact],
        toManyRelations: (Address object) => {},
        getId: (Address object) => object.id,
        setId: (Address object, int id) {
          object.id = id;
        },
        objectToFB: (Address object, fb.Builder fbb) {
          final streetAddress1Offset = fbb.writeString(object.streetAddress1);
          final streetAddress2Offset = fbb.writeString(object.streetAddress2);
          final cityOffset = fbb.writeString(object.city);
          final stateOffset = fbb.writeString(object.state);
          final zipCodeOffset = fbb.writeString(object.zipCode);
          fbb.startTable(8);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, streetAddress1Offset);
          fbb.addOffset(2, streetAddress2Offset);
          fbb.addOffset(3, cityOffset);
          fbb.addOffset(4, stateOffset);
          fbb.addOffset(5, zipCodeOffset);
          fbb.addInt64(6, object.contact.targetId);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final streetAddress1Param =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, '');
          final streetAddress2Param =
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, '');
          final cityParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 10, '');
          final stateParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 12, '');
          final zipCodeParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 14, '');
          final object = Address(
              id: idParam,
              streetAddress1: streetAddress1Param,
              streetAddress2: streetAddress2Param,
              city: cityParam,
              state: stateParam,
              zipCode: zipCodeParam);
          object.contact.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 16, 0);
          object.contact.attach(store);
          return object;
        })
  };

  return obx_int.ModelDefinition(model, bindings);
}

/// [Contact] entity fields to define ObjectBox queries.
class Contact_ {
  /// See [Contact.id].
  static final id =
      obx.QueryIntegerProperty<Contact>(_entities[0].properties[0]);

  /// See [Contact.firstName].
  static final firstName =
      obx.QueryStringProperty<Contact>(_entities[0].properties[1]);

  /// See [Contact.lastName].
  static final lastName =
      obx.QueryStringProperty<Contact>(_entities[0].properties[2]);

  /// See [Contact.phoneNumbers].
  static final phoneNumbers =
      obx.QueryStringVectorProperty<Contact>(_entities[0].properties[3]);

  /// see [Contact.addresses]
  static final addresses =
      obx.QueryBacklinkToMany<Address, Contact>(Address_.contact);
}

/// [Address] entity fields to define ObjectBox queries.
class Address_ {
  /// See [Address.id].
  static final id =
      obx.QueryIntegerProperty<Address>(_entities[1].properties[0]);

  /// See [Address.streetAddress1].
  static final streetAddress1 =
      obx.QueryStringProperty<Address>(_entities[1].properties[1]);

  /// See [Address.streetAddress2].
  static final streetAddress2 =
      obx.QueryStringProperty<Address>(_entities[1].properties[2]);

  /// See [Address.city].
  static final city =
      obx.QueryStringProperty<Address>(_entities[1].properties[3]);

  /// See [Address.state].
  static final state =
      obx.QueryStringProperty<Address>(_entities[1].properties[4]);

  /// See [Address.zipCode].
  static final zipCode =
      obx.QueryStringProperty<Address>(_entities[1].properties[5]);

  /// See [Address.contact].
  static final contact =
      obx.QueryRelationToOne<Address, Contact>(_entities[1].properties[6]);
}
