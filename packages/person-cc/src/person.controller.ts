import * as yup from 'yup';
import { ChaincodeTx } from '@worldsibu/convector-platform-fabric';
import {
  Controller,
  ConvectorController,
  Invokable,
  Param
} from '@worldsibu/convector-core';

import { Person } from './person.model';

@Controller('person')
export class PersonController extends ConvectorController<ChaincodeTx> {
  @Invokable()
  public async create(
    @Param(Person)
    person: Person
  ) {
    await person.save();
  }

  @Invokable()
  public async get(
    @Param(yup.string())
    id: string
  ) {
    const existing = await Person.getOne(id);
    if (!existing || !existing.id) {
      throw new Error(`No person exists with that ID ${id}`);
    }
    return existing;
  }
}
