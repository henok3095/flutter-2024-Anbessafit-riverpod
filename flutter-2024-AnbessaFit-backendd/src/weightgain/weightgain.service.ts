import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CrudUserGain } from './typeorm/crudgainuser';
import { CreatePlanDto } from './dto/create-plan.dto';

@Injectable()
export class WeightGainService {
  constructor(
    @InjectRepository(CrudUserGain)
    private userRepository: Repository<CrudUserGain>,
  ) {}

  create(createPlanDto: CreatePlanDto): Promise<CrudUserGain> {
    const userGain = this.userRepository.create(createPlanDto);
    return this.userRepository.save(userGain);
  }
}
