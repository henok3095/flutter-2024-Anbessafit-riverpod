import { Controller, Post, Body } from '@nestjs/common';
import { WeightGainService } from './weightgain.service';
import { CreatePlanDto } from './dto/create-plan.dto';

@Controller('weightgain')
export class WeightGainController {
  constructor(private readonly weightGainService: WeightGainService) {}

  @Post()
  create(@Body() createPlanDto: CreatePlanDto) {
    return this.weightGainService.create(createPlanDto);
  }
}
